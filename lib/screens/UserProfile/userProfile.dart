import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    mobileNumber = user!.phoneNumber!;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(mobileNumber)
        .get();

    Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

    setState(() {
      _nameController.text = userData?['name'] ?? '';
      _emailController.text = userData?['email'] ?? '';
      _emergencyContactController.text = userData?['emergencyContact'] ?? '';
    });
  }

  Future<void> _updateUserData() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String emergencyContact = _emergencyContactController.text;

    // Validate email format
    if (!isValidEmail(email)) {
      _showErrorDialog('Invalid Email Format');
      return;
    }

    // Validate emergency contact format
    if (!isValidPhoneNumber(emergencyContact)) {
      _showErrorDialog('Invalid Emergency Contact Number');
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
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
                    .delete();

                // Delete user account from Firebase Auth
                await user!.delete();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Account deleted successfully!'),
                  ),
                );

                // Navigate back to login screen
                Navigator.pop(context);
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

  Future<void> _showErrorDialog(String message) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.white, fontFamily: "gilroy"),
        ),
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Registered Mobile Number: $mobileNumber',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emergencyContactController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Emergency Contact',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 45,
              height: 50,
              child: ElevatedButton(
                onPressed: _updateUserData,
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "gilroy",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 45,
              height: 50,
              child: ElevatedButton(
                onPressed: _deleteAccount,
                child: Text(
                  "Delete my Account",
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
            ),
          ],
        ),
      ),
    );
  }
}
