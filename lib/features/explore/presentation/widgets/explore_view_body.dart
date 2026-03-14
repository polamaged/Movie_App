import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/explore/presentation/cubits/moviesbygenre/moviesbygenre_cubit.dart';
import 'package:movies_app/features/explore/presentation/widgets/catagory_slider_item.dart';
import 'package:movies_app/features/explore/presentation/widgets/catagory_item.dart';
import 'package:movies_app/features/explore/presentation/widgets/grid_view_catagory.dart';

class ExploreViewBody extends StatefulWidget {
  const ExploreViewBody({super.key});

  @override
  State<ExploreViewBody> createState() => _ExploreViewBodyState();
}

class _ExploreViewBodyState extends State<ExploreViewBody> {
   String selectedCategory = "Action"; // default category
  @override
  void initState() {
    super.initState();
    // Fetch movies for the default category on init
    context.read<MoviesbygenreCubit>().fetchMoviesbyGenre(genre: selectedCategory);
  }
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 16),
                CatagorySliderItem(
                  onCategorySelected: (String category) {
                    setState(() {
                      selectedCategory = category;
                    });
                    context.read<MoviesbygenreCubit>().fetchMoviesbyGenre(genre: category);
                    print('Selected category: $category');
                  },
                ),
                SizedBox(height: 25),
               GridViewCatagory(category: selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
