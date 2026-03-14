import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_images.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key, required this.onAvatarSelected});
    final Function(String) onAvatarSelected;
  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final PageController controller = PageController(viewportFraction: 0.45);

  List<String> avatars = [
    Assets.imagesAvatar1,
    Assets.imagesAvatar2,
    Assets.imagesAvatar3,
    Assets.imagesAvatar4,
    Assets.imagesAvatar5,
    Assets.imagesAvatar6,
    Assets.imagesAvatar7,
    Assets.imagesAvatar8,
    Assets.imagesAvatar9,
  ];

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: controller,
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          double scale = (1 - (currentPage - index).abs()).clamp(0.7, 1);

          return GestureDetector(
            onTap: () {
              widget.onAvatarSelected(avatars[index]);
            },
            child: Transform.scale(
              scale: scale,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(avatars[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}