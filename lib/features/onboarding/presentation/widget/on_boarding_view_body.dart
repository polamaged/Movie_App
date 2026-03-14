import 'package:flutter/material.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(Assets.imagesMoviesPosters, fit: BoxFit.contain),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,

          child: Column(
            children: [
                Text("Find Your Next" ,textAlign: TextAlign.center, style:TextStyle(fontSize:  MediaQuery.of(context).size.width*0.09,color: Colors.white ,),),
                Text("Favorite Movie Here", textAlign: TextAlign.center, style:TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,color: Colors.white ,),),
                Text("Get access to a huge library of movies" , textAlign: TextAlign.center, style:TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.grey ,),),
                Text("to suit all tastes. You will surely like it" , textAlign: TextAlign.center, style:TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.grey ,),),
                SizedBox(height: 25),
                CustomButtom(onPressed: () {
                  Navigator.pushNamed(context, RouteManager.firstBoarding);
                }, text: "Explore Now", color: Color(0xFFFFD700), textColor: Colors.black, borderColor: Color(0xFFFFD700),),
                
        ],),
        ),
      ],
    );
  }
}
