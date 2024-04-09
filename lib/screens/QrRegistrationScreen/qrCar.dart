import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vehicleNameController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emergencyContactNoController =
      TextEditingController();
  String _qrData = '';
  bool _showQRData = false;
  String? _selectedVehicleType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
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
        color: Colors.black, // Set background color to black
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Vehicle Registration',
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
                    // Remove non-alphabetic characters and allow space
                    _nameController.value = _nameController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                SizedBox(height: 20),
                // Vehicle type dropdown
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Vehicle Type',
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
                    value: _selectedVehicleType,
                    items: ['Two Wheeler', 'Four Wheeler', 'Other']
                        .map((String value) {
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
                    style: TextStyle(color: Colors.white), // Set text color
                    dropdownColor:
                        Colors.black, // Set dropdown background color
                    onChanged: (String? value) {
                      setState(() {
                        _selectedVehicleType = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Brand and Name',
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
                    _vehicleNameController.value =
                        _vehicleNameController.value.copyWith(
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
                  controller: _vehicleNoController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle No.',
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
                  maxLength: 10,
                  onChanged: (value) {
                    // Convert input to uppercase and remove non-alphabetic and non-numeric characters
                    String processedValue = value
                        .toUpperCase()
                        .replaceAll(RegExp(r'[^A-Z0-9]'), '');

                    // Ensure the processed value doesn't exceed the maximum length of 10 characters
                    if (processedValue.length > 10) {
                      processedValue = processedValue.substring(0, 10);
                    }

                    // Update the controller value
                    _vehicleNoController.value =
                        _vehicleNoController.value.copyWith(
                      text: processedValue,
                      selection: TextSelection.collapsed(
                          offset: processedValue.length),
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
                // Generate QR Button
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
                                'Stay Connected to loved ones Download the QR for ${_vehicleNoController.text}',
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: const Color(0xffFF3D3D),
                                ),
                                onPressed: () async {
                                  if (_qrData.isNotEmpty) {
                                    await _saveQrImage();
                                  }
                                },
                                child: const Text(
                                  'Click to downlaod QR',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
      await _generateQRFromFirestoreData(); // Generate QR code from Firestore data
      setState(() {
        _showQRData = true; // Set _showQRData to true when QR data is generated
      });
    } else {
      // Show alert
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

  Future<void> _generateQRFromFirestoreData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final carNumber = _vehicleNoController.text;

      final vehicleDoc = await FirebaseFirestore.instance
          .collection('registeredVehicles')
          .doc(carNumber)
          .get();

      final medicalDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.phoneNumber)
          .collection('medicalInformation')
          .doc(user.phoneNumber)
          .get();

      if (vehicleDoc.exists && medicalDoc.exists) {
        final vehicleData = vehicleDoc.data() as Map<String, dynamic>;
        final medicalData = medicalDoc.data() as Map<String, dynamic>;

        setState(() {
          _qrData =
              'Name: ${vehicleData['name']}, Vehicle Brand & Name: ${vehicleData['vehicleName']}, Vehicle No.: ${vehicleData['vehicleNumber']}, Email: ${vehicleData['email']}, Contact No.: ${vehicleData['contactNumber']}, Emergency Contact No.: ${vehicleData['emergencyContact']}, Blood Type: ${medicalData['bloodType']}, Blood Pressure: ${medicalData['bloodPressure']}, Allergies: ${medicalData['allergies']}, Medications: ${medicalData['medications']}, Organ Donor: ${medicalData['isOrganDonor']}, Medical Notes: ${medicalData['medicalNotes']}, Disease: ${medicalData['disease']}, Immunizations: ${medicalData['immunizations']}';
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _saveDataToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final mobileNumber = user!.phoneNumber;
      final carNumber = _vehicleNoController.text;

      // Check if the car number already exists in Firestore
      final existingDoc = await FirebaseFirestore.instance
          .collection('registeredVehicles')
          .doc(carNumber)
          .get();

      if (existingDoc.exists) {
        // Vehicle is already registered
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Vehicle Already Registered"),
              content: const Text("This vehicle is already registered."),
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
      } else {
        // Convert dropdown value to text
        String vehicleTypeText = '';
        if (_selectedVehicleType == 'Two Wheeler') {
          vehicleTypeText = 'Two Wheeler';
        } else if (_selectedVehicleType == 'Four Wheeler') {
          vehicleTypeText = 'Four Wheeler';
        } else {
          vehicleTypeText = 'Other';
        }

        // Vehicle is not registered, proceed to save data
        await FirebaseFirestore.instance
            .collection('registeredVehicles')
            .doc(carNumber)
            .set({
          'name': _nameController.text,
          'vehicleName': _vehicleNameController.text,
          'vehicleNumber': _vehicleNoController.text,
          'vehicleType': vehicleTypeText,
          'email': _emailController.text,
          'contactNumber': int.parse(_contactNoController.text),
          'emergencyContact': int.parse(_emergencyContactNoController.text),
        });

        // Also save data to the additional collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(mobileNumber)
            .collection('registeredQr')
            .doc(carNumber)
            .set({
          'name': _nameController.text,
          'vehicleName': _vehicleNameController.text,
          'vehicleNumber': _vehicleNoController.text,
          'vehicleType': vehicleTypeText,
          'email': _emailController.text,
          'contactNumber': int.parse(_contactNoController.text),
          'emergencyContact': int.parse(_emergencyContactNoController.text),
        });

        setState(() {
          _qrData =
              'Name: ${_nameController.text}, Vehicle Brand & Name: ${_vehicleNameController.text}, Vehicle No.: ${_vehicleNoController.text}, Vehicle Type: $vehicleTypeText, Email: ${_emailController.text}, Contact No.: ${_contactNoController.text}, Emergency Contact No.: ${_emergencyContactNoController.text}';
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _saveQrImage() async {
    try {
      final image = await QrPainter(
        data: _qrData,
        version: QrVersions.auto,
        gapless: false,
        color: const Color(0xFFFFFFFF), // White color
        emptyColor: const Color(0xFF000000), // Black color
      ).toImageData(300);

      final user = FirebaseAuth.instance.currentUser;
      final vehicleNumber = _vehicleNoController.text;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('qr_codes')
          .child('${user!.uid}_qr_code_$vehicleNumber.png');

      final UploadTask uploadTask =
          storageRef.putData(image!.buffer.asUint8List());

      await uploadTask.whenComplete(() => print('QR code image uploaded'));
      final String downloadURL = await storageRef.getDownloadURL();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black, // Set background color to black
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy'), // Set title text color and font
            contentTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy'), // Set content text color and font
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'QR code image generated successfully for ${_vehicleNoController.text}',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'gilroy',
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal), // Set text color to white
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Launch URL to download the QR code
                    await launch(downloadURL);
                  },
                  child: const Text(
                    'Download',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'gilroy',
                        fontSize: 14.0), // Set font color to black
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xffFFB13D), // Set button background color
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                      fontFamily: 'gilroy',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
            // Add border of color 0xffFFB13D
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffFFB13D)),
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
      );
    } catch (e) {
      print('Error saving QR code image: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Error saving QR code image: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _vehicleNameController.dispose();
    _vehicleNoController.dispose();
    _emailController.dispose();
    _contactNoController.dispose();
    _emergencyContactNoController.dispose();
    super.dispose();
  }

  bool _isValidEmailFormat(String email) {
    // Regular expression for email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
