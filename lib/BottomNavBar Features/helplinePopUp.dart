import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplinePopUp extends StatelessWidget {
  const HelplinePopUp({super.key});

  @override
  Widget build(BuildContext context) {
      void policeCallAndSendImage() async {
    // Capture image using ImagePicker
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Launch WhatsApp with the captured image attached
      final File imageFile = File(pickedFile.path);
      final whatsappUrl =
          "whatsapp://send?phone=&attachment=${Uri.file(imageFile.path)}";
      if (await canLaunchUrl(whatsappUrl as Uri)) {
        await launchUrl(whatsappUrl as Uri);
      } else {
        print('Failed to launch WhatsApp');
      }
    }
  }
  policecall() async {
    await FlutterPhoneDirectCaller.callNumber('100');
  }

  ambulancecall() async {
    await FlutterPhoneDirectCaller.callNumber('108');
  }

  firecall() async {
    await FlutterPhoneDirectCaller.callNumber('101');
  }

  nhaicall() async {
    await FlutterPhoneDirectCaller.callNumber('1800116062');
  }

  roadcall() async {
    await FlutterPhoneDirectCaller.callNumber('1073');
  }

  womencall() async {
    await FlutterPhoneDirectCaller.callNumber('1091');
  }
    return AlertDialog(
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    title: const Text(
                                                      'Helpline Numbers',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        policeCallAndSendImage,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            "assets/images/policeQRLogo.png",
                                                                          ),
                                                                          const Text(
                                                                            "Police",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        ambulancecall,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/ambulanceQRLogo.png"),
                                                                          const Text(
                                                                            "Ambulance",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        firecall,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/fireQRLogo.png"),
                                                                          const Text(
                                                                            "Fire",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        nhaicall,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/nhaiQRLogo.png"),
                                                                          const Text(
                                                                            "NHAI",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        roadcall,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/roadQRLogo.png"),
                                                                          const Text(
                                                                            "Road Emergency",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        womencall,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/sosQRLogo.png"),
                                                                          const Text(
                                                                            "Women Helpline",
                                                                            style:
                                                                                TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
  }
}
