import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class QRWallpaper extends StatefulWidget {
  const QRWallpaper({Key? key}) : super(key: key);

  @override
  _QRWallpaperState createState() => _QRWallpaperState();
}

class _QRWallpaperState extends State<QRWallpaper> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emergencyContactNoController =
      TextEditingController();
  String _qrData = '';
  bool _showQRData = false;
  String? _selectedDeviceType;
  Uint8List? _uploadedImageData;
  double _horizontalPosition = 0.0;
  double _verticalPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Device Registration',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffFFB13D),
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Fill out this registration form & generate the QR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Text('Upload Image'),
                ),
                if (_uploadedImageData != null)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      if (_showQRData)
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Horizontal Position: ${_horizontalPosition.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "gilroy"),
                                ),
                                Slider(
                                  value: _horizontalPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _horizontalPosition = value;
                                    });
                                  },
                                  min: -2000,
                                  max: 2000,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Vertical Position: ${_verticalPosition.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "gilroy"),
                                ),
                                Slider(
                                  value: _verticalPosition,
                                  onChanged: (value) {
                                    setState(() {
                                      _verticalPosition = value;
                                    });
                                  },
                                  min: -800,
                                  max: 800,
                                ),
                              ],
                            ),
                          ],
                        ),
                      Column(
                        children: [
                          SizedBox(height: 20),
                          if (_showQRData)
                            Column(
                              children: [
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //         'Horizontal Position: ${_horizontalPosition.toStringAsFixed(2)}'),
                                //     SizedBox(width: 20),
                                //     // GestureDetector(
                                //     //   onPanUpdate: (details) {
                                //     //     setState(() {
                                //     //       _horizontalPosition +=
                                //     //           details.delta.dx;
                                //     //     });
                                //     //   },
                                //     //   child: Container(
                                //     //     width: 100,
                                //     //     height: 20,
                                //     //     color: Colors.blue,
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //         'Vertical Position: ${_verticalPosition.toStringAsFixed(2)}'),
                                //     SizedBox(width: 20),
                                //     // GestureDetector(
                                //     //   onPanUpdate: (details) {
                                //     //     setState(() {
                                //     //       _verticalPosition += details.delta.dy;
                                //     //     });
                                //     //   },
                                //     //   child: Container(
                                //     //     width: 100,
                                //     //     height: 20,
                                //     //     color: Colors.red,
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
                              ],
                            ),
                          Container(
                            height: MediaQuery.of(context).size.height - 50,
                            width: MediaQuery.of(context).size.width - 50,
                            child: AspectRatio(
                              aspectRatio: 9 / 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(_uploadedImageData!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (_showQRData)
                                      Positioned(
                                        left: _horizontalPosition + 100,
                                        top: _verticalPosition + 100,
                                        child: GestureDetector(
                                          onPanUpdate: (details) {
                                            setState(() {
                                              _horizontalPosition +=
                                                  details.delta.dx;
                                              _verticalPosition +=
                                                  details.delta.dy;
                                            });
                                          },
                                          child: QrImageView(
                                            data: _qrData,
                                            version: QrVersions.auto,
                                            size: 120.0,
                                            backgroundColor:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    _nameController.value = _nameController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Device Type',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    value: _selectedDeviceType,
                    items:
                        ['Smartphone', 'Tablet', 'Laptop'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.black,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDeviceType = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _deviceNameController,
                  decoration: const InputDecoration(
                    labelText: 'Device Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    _deviceNameController.value =
                        _deviceNameController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!_isValidEmailFormat(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _contactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _emergencyContactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Contact No.',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xffFFB13D),
                  ),
                  onPressed: _onGenerateQRPressed,
                  child: const Text(
                    'Generate QR Code',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                if (_showQRData)
                  Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                child: QrImageView(
                                  data: _qrData,
                                  version: QrVersions.auto,
                                  size: 120.0,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Stay Connected to loved ones Download the QR for ${_deviceNameController.text}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onGenerateQRPressed() async {
    if (_formKey.currentState!.validate()) {
      await _saveDataToFirestore(); // Save data to Firestore
      _generateQRFromFirestoreData(); // Generate QR code from Firestore data
      setState(() {
        _showQRData = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Form Error"),
            content: const Text("Please fill the form correctly."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _saveDataToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final mobileNumber = user!.phoneNumber;
      final deviceName = _deviceNameController.text;

      // Save registration data to Firestore under 'registrationData' collection
      await FirebaseFirestore.instance
          .collection('registeredDevices')
          .doc(mobileNumber)
          .set({
        'name': _nameController.text,
        'deviceType': _selectedDeviceType,
        'deviceName': deviceName,
        'email': _emailController.text,
        'contactNo': _contactNoController.text,
        'emergencyContactNo': _emergencyContactNoController.text,
      });

      // Save data to 'wallpaperQr' collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .collection('wallpaperQr')
          .doc(deviceName)
          .set({
        'name': _nameController.text,
        'deviceType': _selectedDeviceType,
        'email': _emailController.text,
        'contactNo': _contactNoController.text,
        'emergencyContactNo': _emergencyContactNoController.text,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _generateQRFromFirestoreData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final mobileNumber = user!.phoneNumber;

      // Retrieve data from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(mobileNumber)
          .collection('wallpaperQr')
          .doc(_deviceNameController.text)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        // Generate QR data
        final qrData =
            'Name: ${data['name']}, Device Type: ${data['deviceType']}, Device Name: ${data['deviceName']}, Email: ${data['email']}, Contact No.: ${data['contactNo']}, Emergency Contact No.: ${data['emergencyContactNo']}';

        setState(() {
          _qrData = qrData;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        _uploadedImageData = imageData;
        _horizontalPosition = 0.0;
        _verticalPosition = 0.0;
      });
    }
  }

  bool _isValidEmailFormat(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
