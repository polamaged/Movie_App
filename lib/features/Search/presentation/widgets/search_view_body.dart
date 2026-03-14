import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/features/Search/presentation/cubits/moviesearch/moviesearch_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';
import 'package:movies_app/core/widgets/search_text_field.dart';

class SearchViewbody extends StatelessWidget {
  const SearchViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 21),
          ),

          SliverToBoxAdapter(
            child: SearchTextField(
              onChanged: (query) {
                context.read<MoviesearchCubit>().fetchSearchMovies(query);
              },
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          BlocBuilder<MoviesearchCubit, MoviesearchState>(
            builder: (context, state) {
              if (state is MoviesearchInitial) {
                return SliverFillRemaining(
                  child: Center(
                    child: Image.asset(Assets.imagesSearchEmpty),
                  ),
                );
              }

              if (state is MoviesearchLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is MoviesearchFailure) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.errMessage)),
                );
              }

              if (state is MoviesearchSuccess) {
                final movies = state.movies;

                if (movies.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Image.asset(Assets.imagesSearchEmpty),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.5),
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final movie = movies[index];
                        return MovieCard(
                          rating: movie.rating ?? 5,
                          imagePath: movie.mediumCoverImage!,
                          movieID: movie.id!,
                        );
                      },
                      childCount: movies.length,
                    ),
                  ),
                );
              }

              return SliverFillRemaining(child: Container());
            },
          ),
        ],
      ),
    );
  }
}