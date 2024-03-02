import 'package:flutter/material.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/firstChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/secondChild.dart';
import 'package:safe_connect/screens/HomeScreen/HomeScreenElements/servicesContainer.dart';

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
          child: Image.asset("assets/images/SafeConnect 1.png"),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: const SingleChildScrollView(
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
