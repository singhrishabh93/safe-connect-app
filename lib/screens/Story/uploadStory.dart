import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Story'),
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
                  getImageFromGallery(); // Open gallery when tapped
                },
                child: _image == null
                    ? IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 50,
                        onPressed: () {
                          getImageFromCamera(); // Open camera when icon tapped
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
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Comment Field
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Rating Option
              Row(
                children: [
                  Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16),
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
              // Upload Button
              ElevatedButton(
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

                  // Upload story data to Firestore under user's document
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(mobileNumber)
                      .collection('story')
                      .add({
                    'name': name,
                    'comment': comment,
                    'rating': _rating,
                    'imageUrl': imageUrl,
                    'timestamp': FieldValue
                        .serverTimestamp(), // Add timestamp for sorting
                  });

                  // Upload story data to Firestore under 'story' collection
                  await FirebaseFirestore.instance
                      .collection('story')
                      .doc(DateTime.now().millisecondsSinceEpoch.toString())
                      .set({
                    'name': name,
                    'comment': comment,
                    'rating': _rating,
                    'imageUrl': imageUrl,
                    'timestamp': FieldValue
                        .serverTimestamp(), // Add timestamp for sorting
                  });

                  // Reset the fields after upload
                  _nameController.clear();
                  _commentController.clear();
                  setState(() {
                    _rating = 0;
                    _image = null;
                  });
                },
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
