import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
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
                          fontSize: 25,
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
                4,
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
                          if (index < 3) {
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
                      // Add your logic for OTP verification
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
