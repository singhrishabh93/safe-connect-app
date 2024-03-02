import 'package:flutter/material.dart';

class services extends StatelessWidget {
  const services({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Services",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Container(
          height: 155,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width - 50,
            child: Image.asset("assets/images/services.png"),
          ),
        ),
      ],
    );
  }
}
