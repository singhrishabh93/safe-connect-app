import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 150.66,
          aspectRatio: (MediaQuery.of(context).size.width - 50) / 97.66,
          enableInfiniteScroll: true,
          viewportFraction: 0.8, // Adjust viewportFraction to add space
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(milliseconds: 3000)),
      items: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5), // Add horizontal margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFF2CF),
          ),
          child: Image.asset("assets/images/carousel1.png"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFF2CF),
          ),
          child: Image.asset("assets/images/carousel1.png"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFF2CF),
          ),
          child: Image.asset("assets/images/carousel1.png"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFF2CF),
          ),
          child: Image.asset("assets/images/carousel1.png"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFF2CF),
          ),
          child: Image.asset("assets/images/carousel1.png"),
        ),
      ],
    );
  }
}
