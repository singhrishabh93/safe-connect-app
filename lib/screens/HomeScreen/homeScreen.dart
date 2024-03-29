import 'package:flutter/material.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/carousel.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/fourthChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/newSecondChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/newThirdChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/welcomeChild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading:
              false // Set elevation to 0 to remove shadow
          ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              WelcomeChild(),
              SizedBox(height: 30),
              // Replace firstChild() with the Carousel
              Carousel(),
              SizedBox(height: 30),
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: newSecondChild()),
              SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: fourthChild()),
              Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: newThirdChild()),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
