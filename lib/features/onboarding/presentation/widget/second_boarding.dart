import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';

class SecondBoarding extends StatelessWidget {
  const SecondBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(Assets.imagesTheGodfather, fit: BoxFit.fill),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xff85210E),
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
          //  height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff121312),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                SizedBox(height: 34),
                Text(
                  "Explore All Genres",
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
                  "Discover movies from every genre, in all",
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
                  "available qualities. Find something new",
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
                  "and exciting to watch every day.",
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
                      Navigator.pushNamed(context, RouteManager.thirdBoarding);
                    },
                    text: "Next",
                    color: Color(0xFFF6BD00),
                    textColor: Colors.black,
                    borderColor: Color(0xFFF6BD00),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButtom(onPressed: () {
                    Navigator.pop(context);
                  }, text: "Back", color: Colors.black, textColor: Color(0xffF6BD00), borderColor: Color(0xffF6BD00),),
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
