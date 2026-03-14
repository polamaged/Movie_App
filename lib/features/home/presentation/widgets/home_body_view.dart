import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/features/home/presentation/widgets/first_half_view.dart';
import 'package:movies_app/features/home/presentation/widgets/second_half_home_view.dart';

class HomeBodyView extends StatefulWidget {
  const HomeBodyView({super.key});

  @override
  State<HomeBodyView> createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  final PageController _controller = PageController(viewportFraction: 0.6);
  double currentPage = 0;
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!_controller.hasClients) return;
      final page = _controller.page ?? 0;
      setState(() {
        currentPage = page;
        currentIndex = page.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              FirstHalfView(
                // currentIndex: currentIndex,
                // controller: _controller,
                // currentPage: currentPage,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
         SliverToBoxAdapter(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: SecondHalfHomeView(),
           ),
         ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SecondHalfHomeView(),
          ),
        ),
      ],
    );
  }
}
