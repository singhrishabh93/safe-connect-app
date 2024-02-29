import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/firstChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/secondChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/servicesContainer.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/thirdChild.dart';
import 'package:safe_connect/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset("assets/images/appbarlogo.png"),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              firstChild(),
              SizedBox(
                height: 30,
              ),
              secondChild(),
              SizedBox(
                height: 30,
              ),
              services(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}