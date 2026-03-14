import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_images.dart';

class CustomeBottomNavigationBar extends StatefulWidget {
  const CustomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  @override
  State<CustomeBottomNavigationBar> createState() =>
      _CustomeBottomNavigationBarState();
}

class _CustomeBottomNavigationBarState
    extends State<CustomeBottomNavigationBar> {
  int _currentIndex = 0; // keeps track of the active icon
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0XFF282A28),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
              widget.onItemSelected(0);
            },
            child: Image.asset(
              _currentIndex == 0
                  ? Assets.imagesHomeActivePng
                  : Assets.imagesHomeInactivePng,
              height: 24,
              width: 24,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
              widget.onItemSelected(1);
            },
            child: Image.asset(
              _currentIndex == 1
                  ? Assets.imagesSearchActive
                  : Assets.imagesSearchInactive,
              height: 24,
              width: 24,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
              widget.onItemSelected(2);
            },
            child: Image.asset(
              _currentIndex == 2
                  ? Assets.imagesExploreActive
                  : Assets.imagesExploreInactive,
              height: 24,
              width: 24,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 3;
              });
              widget.onItemSelected(3);
            },
            child: Image.asset(
              _currentIndex == 3
                  ? Assets.imagesProfileActive
                  : Assets.imagesProfileInactive,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
