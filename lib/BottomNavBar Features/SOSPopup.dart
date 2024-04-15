import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/BottomNavBar%20Features/soundRecorder.dart';
import 'package:safe_connect/BottomNavBar%20Features/videoRecorder.dart';

class SOSPopup extends StatelessWidget {
  const SOSPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Popup'),
        backgroundColor: Color(0xff000000),
      ),
      body: Container(
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
                        text: 'S', style: TextStyle(color: Color(0xffFFFFFf))),
                    TextSpan(
                        text: 'O', style: TextStyle(color: Color(0xffFFB13D))),
                    TextSpan(
                        text: 'S', style: TextStyle(color: Color(0xffFFFFFf))),
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
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur elit.Lore ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum ipsum dolor sit amet, consectetur ipsum ipsum dolor sit amet, consectetur",
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: "gilroy",
                      fontSize: 15),
                ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Get.to(() => SoundRecorderPage());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Audio",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Cirka",
                            fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Get.to(() => VideoRecorderPage());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Video",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Cirka",
                            fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
