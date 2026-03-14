import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class Ordivider extends StatelessWidget {
  const Ordivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color:AppColors.primaryColor,)),
        SizedBox(width: 18),
        Text('OR', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16 , color: AppColors.primaryColor),),
        SizedBox(width: 18),
        Expanded(child: Divider(color: AppColors.primaryColor)),
      ],
    );
  }
}
