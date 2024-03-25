import 'package:flutter/material.dart';

class welcomeChild extends StatefulWidget {
  const welcomeChild({super.key});

  @override
  State<welcomeChild> createState() => _welcomeChildState();
}

class _welcomeChildState extends State<welcomeChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Rishabh Singh",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Welcome to SafeConnect",
                style: TextStyle(fontFamily: "gilroy", fontSize: 20),
              ),
            ],
          ),
          Icon(
            Icons.account_circle,
            size: 50,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
