import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SoundRecorderPage extends StatefulWidget {
  @override
  _SoundRecorderPageState createState() => _SoundRecorderPageState();
}

class _SoundRecorderPageState extends State<SoundRecorderPage> {
  bool _isRecording = false;
  Record? _recorder;
  String? _filePath;
  Timer? _timer;
  int _startRecordingTime = 0;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _requestPermissions();
  }

  Future<void> _initializeRecorder() async {
    if (await _checkPermissions()) {
      _recorder = Record();
    }
  }

  Future<bool> _checkPermissions() async {
    var status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
  }

  void _startRecording() async {
    if (_recorder != null) {
      setState(() {
        _isRecording = true;
        _filePath = null;
        _startRecordingTime = DateTime.now().millisecondsSinceEpoch;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {});
        });
      });

      try {
        await _recorder!.start();
      } catch (e) {
        print('Error starting recording: $e');
      }
    }
  }

  void _stopRecording() async {
    setState(() {
      _isRecording = false;
      _timer?.cancel();
    });

    try {
      _filePath = await _recorder?.stop();
      if (_filePath != null) {
        await _uploadToFirebase();
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _uploadToFirebase() async {
    try {
      if (_filePath != null) {
        File audioFile = File(_filePath!);
        String fileName = audioFile.path.split('/').last;
        String url = await _uploadFileToStorage(audioFile, fileName);

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
          FirebaseStorage.instance.ref().child('audio_logs/$fileName');
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
      'type': 'audio',
      'call To': '100',
      'duration_seconds': _getRecordingDuration(),
      // Include user's details in Firestore document
      'user_details': userData,
    });

    // Fetch emergency contact's details
    String emergencyContact = userData?['emergencyContact'] ?? '';
    DocumentSnapshot emergencyContactDataSnapshot = await FirebaseFirestore.instance
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
      'type': 'audio',
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
    int minutes = durationInSeconds ~/ 60;
    int seconds = durationInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording) Text('Recording...'),
            if (_filePath != null) Text('Recording saved at: $_filePath'),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
