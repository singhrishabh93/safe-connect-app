import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/BottomNavBar%20Features/helplinePopUp.dart';
import 'package:safe_connect/BottomNavBar%20Features/soundRecorder.dart';
import 'package:safe_connect/BottomNavBar%20Features/videoRecorder.dart';

class HelpPopup extends StatelessWidget {
  const HelpPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        text: 'HELP',
                        style: TextStyle(color: Color(0xffFFB13D))),
                    TextSpan(
                        text: 'LINE',
                        style: TextStyle(color: Color(0xffFFFFFf))),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Select option for helpline",
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
                  Get.to(() => HelpLineScreen());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Self",
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
                  Get.to(() => HelpLineScreen());
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Others",
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
