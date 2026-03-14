import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/widgets/custom_error_widget.dart';
import 'package:movies_app/features/home/presentation/cubits/featuredmovies/featuredmovies_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/home/presentation/widgets/row_catagory.dart';

class SecondHalfHomeView extends StatelessWidget {
  const SecondHalfHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<FeaturedmoviesCubit, FeaturedmoviesState>(
      builder: (context, state) {
        if (state is FeaturedmoviesFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }

        if (state is FeaturedmoviesSuccess) {
          // عدد الأفلام في كل صف
          const itemsPerRow = 4;
          final movies = List.of(state.movies)..shuffle(); // ترتيب عشوائي
          final rowCount = (movies.length / itemsPerRow).ceil();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                RowCatagory(),
                const SizedBox(height: 12),
                // كل صف
                Column(
                  children: List.generate(rowCount, (rowIndex) {
                    final start = rowIndex * itemsPerRow;
                    final end = start + itemsPerRow;
                    final rowMovies =
                        movies.sublist(start, end > movies.length ? movies.length : end);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: height * 0.25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rowMovies.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final movie = rowMovies[index];
                            return MovieCard(
                              rating: movie.rating ?? 5,
                              imagePath: movie.mediumCoverImage!,
                              movieID: movie.id!,
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}