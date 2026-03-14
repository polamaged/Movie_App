import 'package:flutter/material.dart';
import 'package:movies_app/features/explore/presentation/widgets/explore_view_body.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ExploreViewBody()));
  }
}
