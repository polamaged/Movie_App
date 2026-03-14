import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';

class FirstBoarding extends StatelessWidget {
  const FirstBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(Assets.imagesFirstboarding, fit: BoxFit.fill),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xff084250),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
           // height: MediaQuery.of(context).size.height * 0.26,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff121312),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                SizedBox(height: 34),
                Text(
                  "Discover Movies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Explore a vast collection of movies in all",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "qualities and genres. Find your next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "favorite film with ease.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButtom(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteManager.secondBoarding);
                    },
                    text: "Next",
                    color: Color(0xFFF6BD00),
                    textColor: Colors.black,
                    borderColor: Color(0xFFF6BD00),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
