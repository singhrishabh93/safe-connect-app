import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:safe_connect/bottomNavBar.dart';

class StoryUploadPage extends StatefulWidget {
  @override
  _StoryUploadPageState createState() => _StoryUploadPageState();
}

class _StoryUploadPageState extends State<StoryUploadPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  int _rating = 0; // Default rating
  File? _image;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageFromGallery();
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageFromCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => bottomNavigationBar());
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Text(
          'Upload Story',
          style: TextStyle(fontFamily: 'Gilroy', color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Upload Option
              GestureDetector(
                onTap: () {
                  _showImageSourceDialog();
                },
                child: _image == null
                    ? IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 50,
                        onPressed: () {
                          _showImageSourceDialog();
                        },
                      )
                    : Image.file(_image!),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Image',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Name Field
              TextField(
                cursorColor: Colors.white,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Comment Field
              TextField(
                cursorColor: Colors.white,
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Rating Option
              Row(
                children: [
                  Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16,color: Colors.white,fontFamily:'Gilroy'),
                  ),
                  SizedBox(width: 10),
                  // Implement Rating Stars here
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                  width: MediaQuery.of(context).size.width - 45,
                  height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB13D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () async {
                    String mobileNumber =
                        FirebaseAuth.instance.currentUser!.phoneNumber!;
                    String name = _nameController.text;
                    String comment = _commentController.text;
                
                    // Upload image to Firebase Storage
                    String imagePath =
                        'story/$mobileNumber/${DateTime.now().millisecondsSinceEpoch}.jpg';
                    TaskSnapshot imageSnapshot = await FirebaseStorage.instance
                        .ref(imagePath)
                        .putFile(_image!);
                    String imageUrl = await imageSnapshot.ref.getDownloadURL();
                
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(mobileNumber)
                        .collection('story')
                        .add({
                      'name': name,
                      'comment': comment,
                      'rating': _rating,
                      'imageUrl': imageUrl,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                
                    await FirebaseFirestore.instance
                        .collection('story')
                        .doc(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      'name': name,
                      'comment': comment,
                      'rating': _rating,
                      'imageUrl': imageUrl,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                
                    _nameController.clear();
                    _commentController.clear();
                    setState(() {
                      _rating = 0;
                      _image = null;
                    });
                  },
                  child: Text('Upload',style: TextStyle(fontFamily: 'Gilroy',color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
