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

          return GestureDetector(
            onTap: () {
              // Navigate to the edit screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditQRDetailsPage(details: details),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registered Vehicle: $docId',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to the edit screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditQRDetailsPage(details: details),
                            ),
                          );
                        },
                      ),
                    ],
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
            ),
          );
        },
      ),
    );
  }
}

class EditQRDetailsPage extends StatefulWidget {
  final Map<String, dynamic> details;

  EditQRDetailsPage({required this.details});

  @override
  _EditQRDetailsPageState createState() => _EditQRDetailsPageState();
}

class _EditQRDetailsPageState extends State<EditQRDetailsPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController contactNumberController;
  late TextEditingController emergencyContactController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.details['name'].toString());
    emailController = TextEditingController(text: widget.details['email'].toString());
    contactNumberController = TextEditingController(text: widget.details['contactNumber'].toString());
    emergencyContactController = TextEditingController(text: widget.details['emergencyContact'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit QR Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextField(
              controller: emergencyContactController,
              decoration: InputDecoration(labelText: 'Emergency Contact'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Updated Name: ${nameController.text}');
                print('Updated Email: ${emailController.text}');
                print('Updated Contact Number: ${contactNumberController.text}');
                print('Updated Emergency Contact: ${emergencyContactController.text}');
                Navigator.pop(context); 
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    emergencyContactController.dispose();
    super.dispose();
  }
}
