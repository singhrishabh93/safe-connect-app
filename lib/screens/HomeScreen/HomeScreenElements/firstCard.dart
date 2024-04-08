import 'package:flutter/material.dart';

class FirstCard extends StatelessWidget {
  const FirstCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: const Color.fromRGBO(27, 27, 28, 0.5299999713897705),
        border: Border.all(
          color: const Color(0xffFF3D3D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 51.18,
              width: 74.08,
              child: Image.asset("assets/images/foundme.png")),
          const SizedBox(height: 20),
          const Text(
            "In case of emergency or loss,",
            style: TextStyle(color: Colors.white, fontFamily: "gilroy"),
          ),
          const Text(
            "quickly reunite with your",
            style: TextStyle(color: Colors.white, fontFamily: "gilroy"),
          ),
          const Text(
            "Family, pets & Stuff",
            style: TextStyle(color: Colors.white, fontFamily: "gilroy"),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 30,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "gilroy",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF3D3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
