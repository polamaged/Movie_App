import 'package:flutter/material.dart';
import 'package:movies_app/features/Search/search_view.dart';
import 'package:movies_app/features/explore/explore_view.dart';
import 'package:movies_app/features/home/presentation/widgets/home_body_view.dart';
import 'package:movies_app/features/profile/presentation/profile_view.dart';

class HomeViewPages extends StatelessWidget {
  const HomeViewPages({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomeBodyView(), // Home View
        SearchView(), // Search View
        ExploreView(), // Favorites View
        ProfileView(), // Profile View
      ],
    );
  }
}
