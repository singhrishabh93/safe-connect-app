import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/LogsScreen/logsScreen.dart';

class newSecondChild extends StatelessWidget {
  const newSecondChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontFamily: "gilroy", fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Our', style: TextStyle(color: Color(0xffFFFFFf))),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: 'Services',
                      style: TextStyle(color: Color(0xffFFB13D))),
                ],
              ),
            )
          ],
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 134,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.to(() => LogScreen());
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/more.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/more.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/more.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/more.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 134,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.to(() => LogScreen());
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/child.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/child.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/child.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/child.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'More',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffFFB13D),
                        fontFamily: 'gilroy',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
