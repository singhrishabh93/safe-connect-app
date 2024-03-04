import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _aadharNoController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emergencyContactNoController = TextEditingController();
  String _qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset("assets/images/SafeConnect 1.png"),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                    child: Text("Car Registration",
                        style: TextStyle(fontSize: 15.0))),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _vehicleNoController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle No.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your vehicle number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _aadharNoController,
                  decoration: const InputDecoration(
                    labelText: 'Aadhar No.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Aadhar number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _contactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _emergencyContactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Contact No.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your emergency contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // backgroundColor: Color(0xFF3199E4),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _qrData =
                                  'Name: ${_nameController.text}, Age: ${_ageController.text}, Vehicle No.: ${_vehicleNoController.text}, Aadhar No.: ${_aadharNoController.text}, Contact No.: ${_contactNoController.text}, Emergency Contact No.: ${_emergencyContactNoController.text}';
                            });
                          } else {
                            // Show alert
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Form Error"),
                                  content:
                                      const Text("Please fill the form correctly."),
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
                        },
                        child: const Text(
                          'Generate QR Code',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: const Color(0xFF3199E4),
                          ),
                          onPressed: () async {
                            if (_qrData.isNotEmpty) {
                              await _saveQrImage();
                            }
                          },
                          child: const Text(
                            'Download QR',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
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
                            size: 150.0,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Download this QR code and stick it on front and back side of your car',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
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

  Future<void> _saveQrImage() async {
    try {
      final image = await QrPainter(
        data: _qrData,
        version: QrVersions.auto,
        gapless: false,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
      ).toImageData(300);
      final directory = await getExternalStorageDirectory();
      final imagePath = '${directory!.path}/qr_code.png';
      final File imageFile = File(imagePath);
      imageFile.writeAsBytesSync(image!.buffer.asUint8List());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('QR Code saved as qr_code.png'),
      ));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _vehicleNoController.dispose();
    _aadharNoController.dispose();
    _contactNoController.dispose();
    _emergencyContactNoController.dispose();
    super.dispose();
  }
}
