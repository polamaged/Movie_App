import 'package:flutter/material.dart';

class CatagoryItem extends StatelessWidget {
  const CatagoryItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.all(12),
        duration: Duration(milliseconds: 200),
        decoration: ShapeDecoration(
          color: isSelected ? Color(0xffF6BD00) : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffF6BD00), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Color(0xffF6BD00),
            ),
          ),
        ),
      ),
    );
  }
}
