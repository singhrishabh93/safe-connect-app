import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/QrRegistrationScreen/qrCar.dart';
import 'package:lottie/lottie.dart';

class carQr extends StatelessWidget {
  const carQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset("assets/images/SafeConnect 1.png"),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: const Center(
                    child: Text(
                  "Product",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Lottie.asset('assets/images/carLottie.json'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Jeevan Raksha | Car",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: RichText(
                      text: const TextSpan(
                          text:
                              "Fill up all the details and generate your unique QR code, paste the QR code stickers on the front and rear windscreen of the car while round stickers are pasted on the and other relevant places of the car. Unfortunately, in the case of a car accident, any person present at the accident site or the police can scan the sticker and immediately give information about the accident to your family and friends along with photos/videos, so that you can get proper medical facility and other help on time. Getting the best help can save your life.",
                          style: TextStyle(color: Colors.black))),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const QRGenerator());
          },
          label: const Text(
            "Register Your Car",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          isExtended: true,
          backgroundColor: const Color(0xFF3199E4),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
