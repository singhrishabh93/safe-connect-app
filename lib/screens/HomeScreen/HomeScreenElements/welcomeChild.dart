import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:safe_connect/screens/UserProfile/userProfile.dart';

class WelcomeChild extends StatefulWidget {
  const WelcomeChild({Key? key});

  @override
  State<WelcomeChild> createState() => _WelcomeChildState();
}

class _WelcomeChildState extends State<WelcomeChild> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_user?.phoneNumber)
                    .collection('loginDetails')
                    .doc(_user?.phoneNumber)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 3),
                          Container(
                            width: 200,
                            height: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text(
                      'Hello,',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cirka',
                          color: Color(0xffffffff)),
                    );
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>?;
                  String name = userData?['name'] ?? 'Name not found';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cirka',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Hello, ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '$name',
                              style: TextStyle(
                                  color: Color(
                                      0xffFFB13D) // Change the color as desired
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Welcome to SafeConnect',
                        style: TextStyle(
                            fontFamily: 'gilroy',
                            fontSize: 20,
                            color: Color(0xffffffff)),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.to(() => UserProfilePage());
            },
            child: const Icon(
              Icons.account_circle,
              size: 50,
              color: Color(0xffFFB13D),
            ),
          ),
        ],
      ),
    );
  }
}
