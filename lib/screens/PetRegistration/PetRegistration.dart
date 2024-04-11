import 'package:flutter/material.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';

class PetRegistration extends StatefulWidget {
  const PetRegistration({super.key});

  @override
  State<PetRegistration> createState() => _PetRegistrationState();
}

class _PetRegistrationState extends State<PetRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
        title: Text('Registration',
            style: TextStyle(color: Colors.white, fontFamily: 'gilroy')),
        backgroundColor: Colors.black,
      ),
    );
  }
}
