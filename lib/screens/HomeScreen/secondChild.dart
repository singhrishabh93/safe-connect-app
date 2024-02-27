import 'package:flutter/material.dart';

class secondChild extends StatelessWidget {
  const secondChild({super.key});

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator Frame7Widget - FRAME
        Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color.fromRGBO(255, 255, 255, 1),
              border: Border.all(
                // color: Color.fromRGBO(0, 0, 0, 1),
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  top: 27,
                  left: 365,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image14.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 77,
                  left: 26,
                  child: Text(
                    'Balance & History',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 139,
                  child: Text(
                    'Personal Loan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 240,
                  child: Text(
                    'Paytm Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 364,
                  child: Text(
                    'Paytm Postpaid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 467,
                  child: Text(
                    'Credit Cards',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 575,
                  child: Text(
                    'Movie Tickets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 80,
                  left: 696,
                  child: Text(
                    'All Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 27,
                  left: 252,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image14.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 27,
                  left: 26,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image15.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 27,
                  left: 139,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(133, 156, 216, 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(50, 50)),
                                ))),
                        Positioned(
                            top: 5,
                            left: 5,
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(19, 33, 86, 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(40, 40)),
                                ))),
                        Positioned(
                            top: 13,
                            left: 19,
                            child: Text(
                              '₹',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            )),
                      ]))),
              Positioned(
                  top: 27,
                  left: 478,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image16.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 27,
                  left: 591,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image17.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 27,
                  left: 704,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Image18.png'),
                            fit: BoxFit.fitWidth),
                      ))),
            ]));
  }
}
