import 'package:flutter/material.dart';

class AvatarItem extends StatelessWidget {
  const AvatarItem({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffF6BD00) : const Color(0xff1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffF6BD00), width: 1.5),
        ),
        child: Center(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(image),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
