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
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name: ${_parseQRData(result!.code!)["Name"] ?? "N/A"}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Age: ${_parseQRData(result!.code!)["Age"] ?? "N/A"}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Vehicle No.: ${_parseQRData(result!.code!)["Vehicle No."] ?? "N/A"}',
                          style: TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _launchPhoneCall(_parseQRData(result!.code!)["Contact No."]);
                          },
                          child: Text('Call Contact'),
                        ),
                        Text(
                          'Emergency Contact No.: ${_parseQRData(result!.code!)["Emergency Contact No."] ?? "N/A"}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  : Text('Scan a QR code to view details'),
            ),
          ),
        ],
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
      String uri = 'tel:$maskedPhoneNumber';
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
