import 'package:flutter/material.dart';

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
                  height: 20,
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
                      "SafeConnect's labels, tags, necklaces and \n bracelets are designed to easily attach to \n clothing or wear comfortably. More robust \n than a medical ID, less invasive than a tracker, \n SafeConnect is designed for everyone's \n peace of mind.",
                      style: TextStyle(fontSize: 9, color: Color(0xffFFFFFf)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 20,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "gilroy",
                              fontSize: 10),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffFF3D3D),
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
