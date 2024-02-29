import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class policeCall extends StatefulWidget {
  const policeCall({super.key});

  @override
  State<policeCall> createState() => _policeCallState();
}

class _policeCallState extends State<policeCall> {
  Uri dialnumber = Uri(scheme: 'tel', path: '100');

  callnumber() async {
    await launchUrl(dialnumber);
  }

  directcall()async{
    await FlutterPhoneDirectCaller.callNumber('100');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
