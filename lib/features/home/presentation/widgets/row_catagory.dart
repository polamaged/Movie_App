import 'package:flutter/material.dart';

class RowCatagory extends StatelessWidget {
  const RowCatagory({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'All Movies',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Spacer(),
     //   Text('See More ', style: TextStyle(color: Color(0xfff6bd00))),
     //   Icon(Icons.arrow_forward, size: 12, color: Color(0xfff6bd00)),
      ],
    );
  }
}
