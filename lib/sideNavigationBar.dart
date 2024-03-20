import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/LoginScreen/loginScreen.dart';
import 'package:safe_connect/screens/UserProfile/userProfile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor:
          Colors.black, // Set total background color of the Drawer to black
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 160,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color:
                    Colors.black, // Set background color of the header to black
              ),
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.phoneNumber)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text(
                      'User Profile',
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                        fontSize: 24,
                      ),
                    );
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>?;

                  String name = userData?['name'] ?? 'Name not found';
                  String mobile =
                      user?.phoneNumber ?? 'Mobile number not found';

                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                              color: Colors.grey, // Set text color to white
                              fontSize: 30,
                              fontFamily: "gilroy"),
                        ),
                        Text(
                          '$name',
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.person, // Profile icon
                color: Colors.white, // Icon color
              ),
              title: Text(
                'Profile',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              tileColor:
                  Colors.black, // Set background color of ListTile to black
              onTap: () {
                Get.to(() => UserProfilePage());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.phone, // Helpline icon
                color: Colors.white, // Icon color
              ),
              title: Text(
                'Helpline',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              tileColor:
                  Colors.black, // Set background color of ListTile to black
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.info, // About Us icon
                color: Colors.white, // Icon color
              ),
              title: Text(
                'About Us',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              tileColor:
                  Colors.black, // Set background color of ListTile to black
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.contact_mail, // Contact Us icon
                color: Colors.white, // Icon color
              ),
              title: Text(
                'Contact Us',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              tileColor:
                  Colors.black, // Set background color of ListTile to black
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Icon(
                Icons.logout, // Logout icon
                color: Colors.white, // Icon color
              ),
              title: Text(
                'Logout',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ), // Logout button
              tileColor:
                  Colors.black, // Set background color of ListTile to black
              onTap: () {
                FirebaseAuth.instance.signOut(); // Sign out the user
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()), // Navigate to login screen
                  (route) =>
                      false, // Clear all routes except for the login screen
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
