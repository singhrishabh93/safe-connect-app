import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;
  late String _scannedSOSPhoneNumber;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

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
        child: Column(
          children: <Widget>[
            const Text(
              "QR Scanner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Expanded(
              flex: 1,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            if (result != null) ...[
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Inform with message",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          onPressed: () {
                            _sendMessage(
                                _parseQRData(result!.code!)["Contact No."],
                                "Vehicle is in No Parking Zone");
                          },
                          child: const Text(
                            'Vehicle is in No Parking Zone',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          onPressed: () {
                            _sendMessage(
                                _parseQRData(result!.code!)["Contact No."],
                                "Vehicle Lights are ON ");
                          },
                          child: const Text('Vehicle Lights are ON ',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          onPressed: () {
                            _sendMessage(
                                _parseQRData(result!.code!)["Contact No."],
                                "MVehicle is being towed");
                          },
                          child: const Text('Vehicle is being towed',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          onPressed: () {
                            _sendMessage(
                                _parseQRData(result!.code!)["Contact No."],
                                "Some damage has occured to the vehicle");
                          },
                          child: const Text('Some damage has occured to the vehicle',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Name: ${_parseQRData(result!.code!)["Name"] ?? "N/A"}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Age: ${_parseQRData(result!.code!)["Age"] ?? "N/A"}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Vehicle No.: ${_parseQRData(result!.code!)["Vehicle No."] ?? "N/A"}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            _launchPhoneCall(
                                _parseQRData(result!.code!)["Contact No."]);
                          },
                          child: const Text(
                            'Call Contact',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        _launchPhoneCall(_parseQRData(
                            result!.code!)["Emergency Contact No."]);
                      },
                      child: const Text(
                        'SOS',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: const Color(0xFF3199E4),
                      ),
                      onPressed: () {
                        _openCamera();
                      },
                      child: const Text(
                        'Camera',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
              // Elevated buttons for sending predefined messages
              // ElevatedButton(
              //   onPressed: () {
              //     _sendMessage(_parseQRData(result!.code!)["Contact No."], "Message 1");
              //   },
              //   child: Text('Send Message 1'),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     _sendMessage(_parseQRData(result!.code!)["Contact No."], "Message 2");
              //   },
              //   child: Text('Send Message 2'),
              // ),
            ],
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _scannedSOSPhoneNumber =
            _parseQRData(result!.code!)["Emergency Contact No."] ?? '';
      });
    });
  }

  Map<String, String> _parseQRData(String qrData) {
    Map<String, String> parsedData = {};
    List<String> fields = qrData.split(', ');
    for (String field in fields) {
      List<String> keyValue = field.split(': ');
      if (keyValue.length == 2) {
        parsedData[keyValue[0]] = keyValue[1];
      }
    }
    return parsedData;
  }

  void _launchPhoneCall(String? phoneNumber) async {
    if (phoneNumber != null) {
      String maskedPhoneNumber = maskPhoneNumber(phoneNumber);
      String lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);
      String uri = 'tel:$maskedPhoneNumber,,,$lastFourDigits';
      await launch(uri);
    }
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length > 4) {
      String lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);
      return '******$lastFourDigits';
    } else {
      return '******';
    }
  }

  void _openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(cameraController: _cameraController),
      ),
    );
  }

  void _sendMessage(String? phoneNumber, String message) async {
    if (phoneNumber != null) {
      final Uri uri = Uri(
          scheme: 'sms', path: phoneNumber, queryParameters: {'body': message});
      await launch(uri.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Phone number not available')));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: widget.cameraController.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(widget.cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final image = await widget.cameraController.takePicture();
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DisplayPictureScreen(imagePath: image.path)),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendImageToSOS(context);
            },
          ),
        ],
      ),
      body: Image.file(File(imagePath)),
    );
  }

  void _sendImageToSOS(BuildContext context) async {
    const String phoneNumber = "7587136215";

    if (phoneNumber.isNotEmpty) {
      const String message = 'Sending image to SOS phone number: $phoneNumber';
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(message)));

      final File imageFile = File(imagePath);
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final String tempImageFilePath = '$tempPath/image.jpg';

      await imageFile.copy(tempImageFilePath);

      String whatsappUrl =
          'whatsapp://send?phone=$phoneNumber&media=$tempImageFilePath';
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No SOS phone number available')));
    }
  }
}
