import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class IvrCall extends StatelessWidget {
  const IvrCall({super.key});

  ivrcall() async {
    await FlutterPhoneDirectCaller.callNumber('9330693306');
  }

  @override
  Widget build(BuildContext context) {
    return ivrcall();
  }
}
