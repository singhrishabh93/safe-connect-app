import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
            Text(
              "QR Scanner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Expanded(
              flex: 2,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${_parseQRData(result!.code!)["Name"] ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Age: ${_parseQRData(result!.code!)["Age"] ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Vehicle No.: ${_parseQRData(result!.code!)["Vehicle No."] ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
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
                          child: Text(
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
                  Container(
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
                      child: Text(
                        'SOS',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color(0xFF3199E4),
                      ),
                      onPressed: () {
                        _openCamera();
                      },
                      child: Text(
                        'Camera',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
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
      String uri = 'tel:$maskedPhoneNumber,,,$phoneNumber';
      await launch(uri);
    }
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length > 4) {
      String lastFourDigits = phoneNumber.substring(phoneNumber.length - 4);
      return '********$lastFourDigits';
    } else {
      return '********';
    }
  }

  void _openCamera() {
    // Implement camera functionality here
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
