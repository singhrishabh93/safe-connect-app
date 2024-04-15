import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';

class VideoRecorderPage extends StatefulWidget {
  @override
  _VideoRecorderPageState createState() => _VideoRecorderPageState();
}

class _VideoRecorderPageState extends State<VideoRecorderPage> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isRecording = false;
  String? _filePath;
  Timer? _timer;
  int _startRecordingTime = 0;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _requestPermissions();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {});
  }

  Future<bool> _checkPermissions() async {
    var status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
  }

  void _startRecording() async {
    if (!_isRecording && _controller.value.isInitialized) {
      setState(() {
        _isRecording = true;
        _filePath = null;
        _startRecordingTime = DateTime.now().millisecondsSinceEpoch;
        _elapsedSeconds = 0;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _elapsedSeconds++;
          });
        });
      });

      try {
        await _controller.startVideoRecording();
      } catch (e) {
        print('Error starting video recording: $e');
        setState(() {
          _isRecording = false;
          _timer?.cancel();
        });
      }
    }
  }

  void _stopRecording() async {
    if (_isRecording) {
      setState(() {
        _isRecording = false;
        _timer?.cancel();
      });

      try {
        XFile videoFile = await _controller.stopVideoRecording();
        _filePath = videoFile.path;
        if (_filePath != null) {
          await _uploadToFirebase();
        }
      } catch (e) {
        print('Error stopping video recording: $e');
      }
    }
  }

  Future<void> _uploadToFirebase() async {
    try {
      if (_filePath != null) {
        File videoFile = File(_filePath!);
        String fileName = videoFile.path.split('/').last;
        String url = await _uploadFileToStorage(videoFile, fileName);

        if (url.isNotEmpty) {
          await _uploadDataToFirestore(url);
        }
      }
    } catch (e) {
      print('Error uploading to Firebase: $e');
    }
  }

  Future<String> _uploadFileToStorage(File file, String fileName) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('video_logs/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      return '';
    }
  }

  Future<void> _uploadDataToFirestore(String url) async {
    try {
      Position position = await _getCurrentLocation();
      String address = await _getAddressFromCoordinates(
          position.latitude, position.longitude);

      final user = FirebaseAuth.instance.currentUser;
      final mobileNumber = user!.phoneNumber;

      String randomId = DateTime.now().millisecondsSinceEpoch.toString();

      // Fetch user's complete details
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .collection('loginDetails')
          .doc(mobileNumber)
          .get();
      Map<String, dynamic>? userData =
          userDataSnapshot.data() as Map<String, dynamic>?;

      // Print user's complete details in the terminal
      print('User Details:');
      print('Name: ${userData?['name']}');
      print('Email: ${userData?['email']}');
      print('Emergency Contact: ${userData?['emergencyContact']}');

      // Upload data to Firestore for the user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .collection('logs')
          .doc(randomId)
          .set({
        'mediaLink': url,
        'address': address,
        'type': 'video',
        'call To': '100',
        'duration_seconds': _getRecordingDuration(),
        // Include user's details in Firestore document
        'user_details': userData,
      });

      // Fetch emergency contact's details
      String emergencyContact = userData?['emergencyContact'] ?? '';
      DocumentSnapshot emergencyContactDataSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(emergencyContact) // Use emergency contact as the document ID
              .collection('loginDetails')
              .doc(emergencyContact)
              .get();
      Map<String, dynamic>? emergencyContactData =
          emergencyContactDataSnapshot.data() as Map<String, dynamic>?;

      // Upload data to Firestore for the emergency contact
      await FirebaseFirestore.instance
          .collection('users')
          .doc(emergencyContact)
          .collection('logsForEmergencyContact')
          .doc(randomId)
          .set({
        'mediaLink': url,
        'address': address,
        'type': 'video',
        'call To': '100',
        'duration_seconds': _getRecordingDuration(),
        // Include user's details in Firestore document
        'user_details': userData,
      });

      Navigator.pop(context);

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

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        return '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country} - ${placemark.postalCode ?? ''}';
      } else {
        return 'Unknown location';
      }
    } catch (e) {
      print('Error fetching location: $e');
      return 'Unknown location';
    }
  }

  String _getRecordingDuration() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int durationInSeconds =
        ((currentTime - _startRecordingTime) / 1000).round();
    return _formatDuration(durationInSeconds);
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recorder'),
      ),
      body: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isRecording)
                    Text(
                        'Recording... Duration: ${_formatDuration(_elapsedSeconds)}'),
                  if (_filePath != null) Text('Recording saved at: $_filePath'),
                  ElevatedButton(
                    onPressed:
                        _isRecording ? _stopRecording : _startRecording,
                    child: Text(
                        _isRecording ? 'Stop Recording' : 'Start Recording'),
                  ),
                  SizedBox(height: 20),
                  if (_controller.value.isInitialized)
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
