import 'package:flutter/material.dart';
import 'package:safe_connect/theme.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Stack(children: <Widget>[
            Positioned(
                top: MediaQuery.of(context).size.height - 200,
                left: MediaQuery.of(context).size.width / 2 - 42,
                child: Container(
                    width: 84,
                    height: 117,
                    child: const Positioned(
                        top: 87,
                        left: 0,
                        child: Text(
                          'MADE WITH FLUTTER ❤️',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )))),
            Positioned(
                child: Center(
              child: Container(
                  width: 200,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitWidth),
                  )),
            )),
            // Positioned(
            //     bottom: 100,
            //     child: Container(
            //       margin: EdgeInsets.all(130),
            //       child: Text(
            //         "Made with Flutter ❤️",
            //       ),
            //     )),
          ])),
    );
  }
}
