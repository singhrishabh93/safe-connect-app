import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class HelpLineScreen extends StatefulWidget {
  const HelpLineScreen({Key? key});

  @override
  State<HelpLineScreen> createState() => _HelpLineScreenState();
}

class _HelpLineScreenState extends State<HelpLineScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _requestPermissions();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.location,
    ].request();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpline'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CameraScreen(cameraController: _cameraController),
              ),
            );
          },
          child: const Text('Get help!'),
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraController cameraController;

  const CameraScreen({Key? key, required this.cameraController})
      : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isImageMode = true; // Default to image mode
  late Future<void> _initializeControllerFuture;
  bool _isUploading = false; // Track if the image is uploading

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = widget.cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(widget.cameraController);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          if (_isUploading)
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black.withOpacity(0.5),
              // value: AlwaysStoppedAnimation<Color>(value)
              strokeWidth: 3,
            ),
              // ..color = Colors.white
              // ..backgroundColor = Colors.black.withOpacity(0.5)
              // ..valueColor = AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.8))
              // ..strokeWidth = 3,
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              onPressed: _isUploading ? null : _captureMedia,
              icon: Icon(Icons.camera_alt),
              iconSize: 48,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _captureMedia() async {
    try {
      setState(() {
        _isUploading = true; // Set uploading to true when capturing media
      });

      XFile? mediaFile; // Initialize mediaFile here

      if (_isImageMode) {
        mediaFile = await widget.cameraController.takePicture();
      } else {
        // Logic for capturing video
      }

      // Proceed only if mediaFile is not null
      if (mediaFile != null) {
        // Get user's current location
        Position position = await _getCurrentLocation();

        // Upload media file to Firebase Storage
        String imageUrl = await _uploadImageToStorage(File(mediaFile.path));

        // Upload media file link and location to Firestore
        await _uploadDataToFirestore(imageUrl, position);

        setState(() {
          _isUploading = false; // Set uploading to false after upload is complete
        });
      }
    } catch (e) {
      print("Error capturing media: $e");
      setState(() {
        _isUploading = false; // Set uploading to false if an error occurs
      });
    }
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('logs/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      return '';
    }
  }

  Future<void> _uploadDataToFirestore(
      String imageUrl, Position position) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final mobileNumber = user!.phoneNumber;

      // Generate a random document ID
      String randomId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload media file link and location to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .collection('logs')
          .doc(randomId)
          .set({
        'imageLink': imageUrl,
        'location': GeoPoint(position.latitude, position.longitude),
        'type': _isImageMode
            ? 100
            : 200, // 100 for image, 200 for video (you can adjust as needed)
      });

      // Navigate back after successful upload
      Navigator.pop(context);

      // Initiate a phone call to the emergency number
      String phoneNumber = '100';
      if (await canLaunch(phoneNumber)) {
        await launch(phoneNumber);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print("Error uploading data to Firestore: $e");
    }
  }
}