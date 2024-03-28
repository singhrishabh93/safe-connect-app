import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/LoginScreen/loginScreen.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();

  late User? user;
  late String mobileNumber;
  bool isEditMode = false;
  bool showDeleteButton = false;
  Map<String, dynamic> registeredQrDetails = {};
  bool showRegisteredQr =
      false; // New flag to control visibility of registered QR details

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    mobileNumber = user!.phoneNumber!;
    _fetchUserData();
    _fetchRegisteredQrDetails(); // Fetch registered QR details
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('loginDetails')
        .doc(mobileNumber)
        .get();

    Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

    setState(() {
      _nameController.text = userData?['name'] ?? '';
      _emailController.text = userData?['email'] ?? '';
      _emergencyContactController.text = userData?['emergencyContact'] ?? '';
    });
  }

  Future<void> _fetchRegisteredQrDetails() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('registeredQr')
        .get();

    if (snapshot.docs.isNotEmpty) {
      registeredQrDetails.clear();
      snapshot.docs.forEach((doc) {
        registeredQrDetails[doc.id] = doc.data();
      });
      setState(() {});
    }
  }

  // Rest of the methods remain unchanged

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black, fontFamily: "gilroy"),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Registered Mobile Number: $mobileNumber',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'gilroy',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'gilroy',
              ),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              enabled: isEditMode,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'gilroy',
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              enabled: isEditMode,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emergencyContactController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'gilroy',
              ),
              decoration: InputDecoration(
                labelText: 'Emergency Contact',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'gilroy',
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              enabled: isEditMode,
            ),
            SizedBox(height: 25),
            Text(
              'Registered QR Details',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'gilroy',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            if (showRegisteredQr) // Conditionally show registered QR details above the button
              Expanded(
                child: ListView.builder(
                  itemCount: registeredQrDetails.length,
                  itemBuilder: (context, index) {
                    String docId = registeredQrDetails.keys.elementAt(index);
                    Map<String, dynamic> details =
                        registeredQrDetails.values.elementAt(index);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registered Vehicle: $docId',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 2),
                        Text(
                          'Name: ${details['name']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Vehicle Name: ${details['vehicleName']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Vehicle Number: ${details['vehicleNumber']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Email: ${details['email']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Contact Number: ${details['contactNumber']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Emergency Contact: ${details['emergencyContact']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showRegisteredQr = !showRegisteredQr; // Toggle the flag
                });
                if (showRegisteredQr) {
                  _fetchRegisteredQrDetails(); // Fetch registered QR details if the flag is true
                }
              },
              child: Text(
                showRegisteredQr ? 'Hide QR Details' : 'Show QR Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "gilroy",
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEditMode) {
                    _updateUserData();
                  }
                  isEditMode = !isEditMode;
                });
              },
              child: Text(
                isEditMode ? 'Save Detail' : 'Edit Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "gilroy",
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isEditMode ? Colors.green : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut(); // Sign out the user
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "gilroy",
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (showDeleteButton)
              ElevatedButton(
                onPressed: _deleteAccount,
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "gilroy",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserData() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String emergencyContact = _emergencyContactController.text;

    // Validate email format
    if (!isValidEmail(email)) {
      _showErrorDialog(context, 'Invalid Email Format');
      return;
    }

    // Validate emergency contact format
    if (!isValidPhoneNumber(emergencyContact)) {
      _showErrorDialog(context, 'Invalid Emergency Contact Number');
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .collection('loginDetails')
        .doc(mobileNumber)
        .update({
      'name': name,
      'email': email,
      'emergencyContact': emergencyContact,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User data updated successfully!'),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Confirm Account Deletion',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Delete user document from Firestore
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(mobileNumber)
                    .collection('loginDetails')
                    .doc(mobileNumber)
                    .delete();

                // Delete user account from Firebase Auth
                await user!.delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Account deleted successfully!'),
                  ),
                );

                // Navigate back to login screen
                Get.to(() => LoginScreen());
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
