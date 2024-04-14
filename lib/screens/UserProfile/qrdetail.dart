import 'package:flutter/material.dart';

class QRDetailsPage extends StatelessWidget {
  final Map<String, dynamic> qrDetails;

  const QRDetailsPage({Key? key, required this.qrDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Details'),
      ),
      body: qrDetails.isNotEmpty
          ? ListView.builder(
              itemCount: qrDetails.length,
              itemBuilder: (context, index) {
                String docId = qrDetails.keys.elementAt(index);
                Map<String, dynamic> details = qrDetails.values.elementAt(index);

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
            )
          : Center(
              child: Text('No QR Details found.'),
            ),
    );
  }
}
