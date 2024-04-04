import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_connect/bottomNavBar.dart';
import 'package:safe_connect/bottomNavigationBar.dart';

class SignUpScreen extends StatefulWidget {
  final String mobileNumber;

  const SignUpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  bool _isButtonClicked = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 760,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 21,
                            fontFamily: "cirka",
                          ),
                          child: Text(
                            "Membership Application",
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
                            "Tell us little bit about yourself",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 45,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                child: TextFormField(
                  controller: _emergencyContactController,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Contact Number',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your emergency contact number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your emergency contact number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid 10-digit number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                          _isButtonClicked = _isChecked;
                        });
                      },
                      activeColor: Colors.black,
                    ),
                    Text(
                      'I agree to the terms and conditions',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "gilroy",
                        color: _isChecked ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isButtonClicked ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonClicked
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "gilroy",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _emergencyContactController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Missing Information'),
            content: const Text('Please fill in all the required fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      try {
        // Add the user details to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.mobileNumber) // Using mobileNumber as document ID
            .collection('loginDetails')
            .doc(widget.mobileNumber) // Using mobileNumber as document ID
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'emergencyContact': _emergencyContactController.text,
          'mobileNumber': widget.mobileNumber, // Include mobileNumber
        });

        // Show success message
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Successful'),
              content: const Text('Your details have been successfully saved.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => bottomNavigationBar(),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Error adding user to Firestore: $e');
        // Show error message with actual error
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
