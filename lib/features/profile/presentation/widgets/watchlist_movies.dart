import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/profile/presentation/cubits/watchlist/watchlist_cubit.dart';

class WatchListMovies extends StatelessWidget {
  const WatchListMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        final movies = state is WatchlistUpdated ? state.movies : [];

        if (movies.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Image.asset(Assets.imagesSearchEmpty),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final movie = movies[index];
                return MovieCard(
                  rating: movie.rating ?? 5,
                  imagePath: movie.mediumCoverImage ?? "",
                  movieID: movie.id ?? 0,
                );
              },
              childCount: movies.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio:
                  MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
            ),
          ),
        );
      },
    );
  }
}