import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.imagePath,
    this.userName,
    required this.radius,
  });

  final String imagePath;
  final String? userName;
  final int radius;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius.toDouble(),
          backgroundColor: Colors.grey,
          child: Image.asset(imagePath),
        ),
        SizedBox(height: 15),
        Text(
          userName ?? '',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
