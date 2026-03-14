import 'package:flutter/material.dart';
import 'package:movies_app/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:movies_app/features/home/presentation/widgets/home_view_pages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int currentViewIndex = 0;

class _HomeState extends State<Home> {
  void changeTab(int index) {
    setState(() {
      currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeViewPages(currentIndex: currentViewIndex),

          Positioned(
            left: 9,
            right: 9,
            bottom: 9,
            child: CustomeBottomNavigationBar(
              selectedIndex: currentViewIndex,
              onItemSelected: (value) {
                setState(() {
                  currentViewIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
