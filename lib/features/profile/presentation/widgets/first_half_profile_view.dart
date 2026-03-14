import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/features/Auth/data/models/user_models.dart';
import 'package:movies_app/features/Auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:movies_app/features/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:movies_app/features/profile/presentation/cubits/watchlist/watchlist_cubit.dart';
import 'package:movies_app/features/profile/presentation/widgets/circle_avatar.dart';
import 'package:movies_app/features/profile/presentation/widgets/counter_item.dart';

class FirstHalfProfileView extends StatefulWidget {
  const FirstHalfProfileView({super.key, required this.onTabChanged});

  final Function(int) onTabChanged;
  @override
  State<FirstHalfProfileView> createState() => _FirstHalfProfileViewState();
}

class _FirstHalfProfileViewState extends State<FirstHalfProfileView> {
  int selectedTab = 0;
  // 0 = WatchList , 1 = History
  String selectedAvatar = Assets.imagesAvatar1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileUpdated) {
                    return CustomCircleAvatar(
                      imagePath: state.user.avatar,
                      userName: state.user.name,
                      radius: 50,
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              const SizedBox(width: 30),
              const SizedBox(height: 20),
              BlocBuilder<WatchlistCubit, WatchlistState>(
                builder: (context, state) {
                  if (state is WatchlistUpdated) {
                    int watchlistCount = state.movies.length;
                    return CounterItem(
                      number: watchlistCount.toString(),
                      label: 'Watch List',
                    );
                  }
                  return CounterItem(number: '0', label: 'Watch List');
                },
              ),
              SizedBox(width: 40),
              CounterItem(number: '10', label: 'History'),
            ],
          ),
        ),
        SizedBox(height: 23),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 56,
                child: _yellowButton('Edit Profile'),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 56,
                child: _redButton(),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _tabItem(index: 0, icon: Icons.list, text: 'Watch List'),
            ),
            SizedBox(width: 40),
            Expanded(
              child: _tabItem(index: 1, icon: Icons.folder, text: 'History'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    final isActive = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });

        widget.onTabChanged(index);
      },
      child: Column(
        children: [
          Column(
            children: [
              Icon(icon, color: const Color(0xffF6BD00), size: 40),
              const SizedBox(height: 6),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Indicator
          if (isActive)
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                height: 2,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.amber,
              ),
            ),
        ],
      ),
    );
  }

  Widget _yellowButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFD700),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      onPressed: () async {
        await Navigator.pushNamed(context, RouteManager.editProfile);

      // بعد ما المستخدم يرجع، اعمل fetch جديد للبيانات
      context.read<ProfileCubit>().getUserData();
      },
      child: Text(text, style: TextStyle(fontSize: 20)),
    );
  }

  Widget _redButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFE82626),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      onPressed: () {
        context.read<LoginCubit>().signOut();
         if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteManager.login,
          (route) => false,
        );
      }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Exit', style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(width: 6),
          Icon(Icons.logout, size: 18, color: Colors.white),
        ],
      ),
    );
  }
}
