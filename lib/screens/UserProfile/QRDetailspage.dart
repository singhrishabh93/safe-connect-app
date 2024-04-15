import 'package:flutter/material.dart';

class QRDetailsPage extends StatelessWidget {
  final Map<String, dynamic> registeredQrDetails;

  QRDetailsPage({required this.registeredQrDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Details'),
      ),
      body: ListView.builder(
        itemCount: registeredQrDetails.length,
        itemBuilder: (context, index) {
          String docId = registeredQrDetails.keys.elementAt(index);
          Map<String, dynamic> details =
              registeredQrDetails.values.elementAt(index);

          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registered Vehicle: $docId',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Name: ${details['name']}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Vehicle Name: ${details['vehicleName']}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Vehicle Number: ${details['vehicleNumber']}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Email: ${details['email']}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Contact Number: ${details['contactNumber']}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Emergency Contact: ${details['emergencyContact']}',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}