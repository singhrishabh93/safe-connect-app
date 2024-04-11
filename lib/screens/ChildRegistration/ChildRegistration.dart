import 'package:flutter/material.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';

class ChildRegistration extends StatefulWidget {
  const ChildRegistration({super.key});

  @override
  State<ChildRegistration> createState() => _ChildRegistrationState();
}

class _ChildRegistrationState extends State<ChildRegistration> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final TextEditingController _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text('Registration',
            style: TextStyle(
              fontFamily: 'gilroy',
              fontSize: 16.0,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Child Registration',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffFFB13D),
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Fill out this registration form & generate the QR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 40.0),
            






              ],
            ),
          ),
        ),
      ),
    );
  }
}
