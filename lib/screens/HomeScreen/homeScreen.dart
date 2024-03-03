import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/ChatBot/chatBot.dart';
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
          title: Center(
            child: Container(
              child: Image.asset("assets/images/SafeConnect 1.png"),
            ),
          ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.support_agent_outlined,
                size: 30,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Get.to(() => ChatScreen());
              },
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Helpline"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("About Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
