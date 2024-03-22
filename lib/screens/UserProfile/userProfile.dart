import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
    // Your update user data logic here
    // ...
  }

  Future<void> _deleteAccount() async {
    // Your delete account logic here
    // ...
  }

  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut(); // Sign out the user
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()), // Navigate to login screen
                  (route) =>
                      false, // Clear all routes except for the login screen
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
              enabled: isEditMode, // Enable/disable based on edit mode
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
              enabled: isEditMode, // Enable/disable based on edit mode
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
              enabled: isEditMode, // Enable/disable based on edit mode
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(height: 20),
            isEditMode
                ? Row(
                    children: [
                      Expanded(
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
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditMode = false; // Exit edit mode
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
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
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditMode = true; // Enter edit mode
                      });
                    },
                    child: Text(
                      "Edit Details",
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
            SizedBox(height: 10),
            isEditMode
                ? SizedBox()
                : ElevatedButton(
                    onPressed: _signOut,
                    child: Text(
                      "Sign Out",
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
            SizedBox(height: 10),
            isEditMode
                ? ElevatedButton(
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
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
