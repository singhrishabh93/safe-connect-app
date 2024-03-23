import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_connect/bottomNavBar.dart';
import 'package:safe_connect/screens/SignUpScreen/signUpScreen.dart';
import 'package:safe_connect/bottomNavigationBar.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String verificationId;

  const OtpScreen(
      {Key? key, required this.mobileNumber, required this.verificationId})
      : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _signInWithPhoneNumber(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Check if the user's mobile number is already registered
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.mobileNumber)
            .collection('loginDetails')
            .doc(widget.mobileNumber)
            .get();

        if (userSnapshot.exists) {
          // User is already registered, navigate to BottomNavigationBar
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => bottomNavigationBar(),
            ),
          );
        } else {
          // User is not registered, navigate to SignUpScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpScreen(
                mobileNumber: widget.mobileNumber,
              ),
            ),
          );
        }
      } else {
        print("Authentication failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 678,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 88, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "gilroy",
                        ),
                        child: Text(
                          "MEMBERSHIP APPLICATION",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "gilroy",
                        ),
                        child: Text(
                          "Enter OTP sent to ${widget.mobileNumber}",
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        } else {
                          if (index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        }
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "gilroy",
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      String otp = _controllers.fold(
                          "", (prev, controller) => prev + controller.text);
                      _signInWithPhoneNumber(otp);
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
          ],
        ),
      ),
    );
  }
}
