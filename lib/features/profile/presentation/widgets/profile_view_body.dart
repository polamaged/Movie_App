import 'package:flutter/material.dart';
import 'package:movies_app/features/profile/presentation/widgets/first_half_profile_view.dart';
import 'package:movies_app/features/profile/presentation/widgets/historymovies.dart';
import 'package:movies_app/features/profile/presentation/widgets/watchlist_movies.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
    int selectedTab = 0;
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: const Color(0xFF212121),
            child: FirstHalfProfileView(onTabChanged: (index) {
              setState(() {
                selectedTab = index;
              });
            }),
          ),
        ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        if (selectedTab == 0)
          const WatchListMovies()
        else
          const HistoryMovies(),
           SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
      ],
    );
  }
}