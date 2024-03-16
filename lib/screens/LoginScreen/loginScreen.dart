import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool _isChecked = false;

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
                const Padding(
                  padding: EdgeInsets.only(top: 200, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: "gilroy"),
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
                            fontFamily: "gilroy"),
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
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: TextStyle(
                      color: Colors.grey, fontSize: 15, fontFamily: "gilroy"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.black, fontSize: 15, fontFamily: "gilroy"),
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
                      });
                    },
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(
                        fontSize: 14, fontFamily: "gilroy", color: Colors.grey),
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
                onPressed: () {},
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: "gilroy"),
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
      ),
    );
  }
}
