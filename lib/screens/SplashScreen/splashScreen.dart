import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/bottomNavBar.dart';
import 'package:safe_connect/bottomNavigationBar.dart';
import 'package:safe_connect/screens/LoginScreen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _hasInternet = true;
      });
      _redirectAfterDelay();
    } else {
      // No internet connection
      _showNoInternetPopup();
    }
  }

  Future<void> _redirectAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    // Check if the user is already logged in
    if (FirebaseAuth.instance.currentUser != null) {
      // User is already logged in, redirect to bottom navigation bar
      // Get.offAll(() => bottomNavigationBar()); // Assuming bottomNavigationBar is your bottom navigation bar screen
      Get.offAll(() => bottomNavigationBar()); // Assuming bottomNavigationBar is your bottom navigation bar screen
    } else {
      // User is not logged in, redirect to login screen
      Get.offAll(() => const LoginScreen());
    }
  }

  void _showNoInternetPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("No Internet Connection"),
          content: const Text("Please check your internet connection and try again."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _checkInternet();
              },
              child: const Text("Try Again"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/splash.gif",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
        ],
      ),
    );
  }
}