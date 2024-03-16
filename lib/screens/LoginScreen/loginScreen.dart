import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  bool _isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 580,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          fontSize: 25,
                          fontFamily: "gilroy",
                        ),
                        child: Text(
                          "Tell us your mobile number",
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
            Container(
              width: MediaQuery.of(context).size.width - 45,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ], // Only allow digits
                maxLength: 10, // Limit to 10 digits
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "gilroy",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  counterText: null, // Remove the limit text
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: "gilroy",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 45,
              height: 50,
              child: ElevatedButton(
                onPressed: _isChecked ? () {} : null,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "gilroy",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonClicked
                      ? Colors.black
                      : Colors.grey.withOpacity(0.5),
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
