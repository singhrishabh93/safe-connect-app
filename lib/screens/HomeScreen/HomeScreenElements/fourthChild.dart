import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/MedicalInformation/medicalInformation.dart';

class fourthChild extends StatelessWidget {
  const fourthChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontFamily: "gilroy", fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Medical',
                      style: TextStyle(color: Color(0xffFFFFFf))),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: 'Emergency',
                      style: TextStyle(color: Color(0xffFFB13D))),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
              color: Color(0xff1A1A1A),
              borderRadius: BorderRadius.circular(10)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontFamily: "Cirka", fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Stay',
                            style: TextStyle(color: Color(0xffFFFFFf))),
                        TextSpan(text: ' '),
                        TextSpan(
                            text: 'Connected',
                            style: TextStyle(color: Color(0xffFFB13D))),
                        TextSpan(text: ' '),
                        TextSpan(
                            text: 'to loved ones',
                            style: TextStyle(color: Color(0xffFFFFFf))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      "SafeConnect's wearable peace of mind \ncomfortable, non-invasive, and simple \nfor all.",
                      style: TextStyle(fontSize: 10, color: Color(0xffFFFFFf)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => MedicalInformationPage());
                        },
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "gilroy",
                              fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF3D3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                  height: 120,
                  child: Image.asset("assets/images/RedCross.png")),
            )
          ]),
        )
      ],
    );
  }
}
