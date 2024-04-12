import 'package:flutter/material.dart';
import 'package:safe_connect/theme.dart';

class SOSPopup extends StatelessWidget {
  const SOSPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Popup'),
        backgroundColor: Color(0xff000000),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: 5000,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color(0xff000000)),
            child: Column(
              children: [
                const SizedBox(height: 30),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontFamily: "gilroy", fontSize: 40),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'S',
                          style: TextStyle(color: Color(0xffFFFFFf))),
                      TextSpan(
                          text: 'O',
                          style: TextStyle(color: Color(0xffFFB13D))),
                      TextSpan(
                          text: 'S',
                          style: TextStyle(color: Color(0xffFFFFFf))),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Select option for SOS",
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: "gilroy",
                      fontSize: 15),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Audio",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Cirka",
                            fontSize: 30)),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Video",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Cirka",
                            fontSize: 30)),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }
}
