import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/download_helper.dart';
import 'package:movies_app/core/widgets/custom_error_widget.dart';
import 'package:movies_app/features/home/presentation/cubits/deatilsmovie/deatilsmovie_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/profile/presentation/cubits/watchlist/watchlist_cubit.dart';

class DetailsMovieCard extends StatefulWidget {
  const DetailsMovieCard({super.key, required this.movieID});
  final int movieID;

  @override
  State<DetailsMovieCard> createState() => _DetailsMovieCardState();
}

class _DetailsMovieCardState extends State<DetailsMovieCard> {
  void initState() {
    super.initState();
    context.read<DeatilsmovieCubit>().fetchMoviesbyID(widget.movieID);
  }

  void didUpdateWidget(covariant DetailsMovieCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieID != widget.movieID) {
    // مسح الحالة القديمة
    context.read<DeatilsmovieCubit>().emit(DeatilsmovieInitial());
    // اعمل fetch للفيلم الجديد
    context.read<DeatilsmovieCubit>().fetchMoviesbyID(widget.movieID);
  }
  void didChangeDependencies() {
  super.didChangeDependencies();
  // أول مرة يبني فيها الـ widget
  context.read<DeatilsmovieCubit>().fetchMoviesbyID(widget.movieID);
}
  }
  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.5;

    log('Fetching details for movie ID: ${widget.movieID}');
    return BlocBuilder<DeatilsmovieCubit, DeatilsmovieState>(
      builder: (context, state) {
        if (state is DeatilsmovieFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }
        if (state is DeatilsmovieSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // 🌟 الصورة مع Play button و AppBar
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // صورة blur
                      Positioned.fill(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 1,
                            sigmaY: 2,
                            tileMode: TileMode.mirror,
                          ),

                          child: Image.network(
                            state.movie.mediumCoverImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // AppBar شفاف فوق الصورة
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          iconTheme: const IconThemeData(
                            color: Colors.white,
                            size: 30,
                          ),
                          actions: [
                            BlocBuilder<WatchlistCubit, WatchlistState>(
                              builder: (context, watchState) {
                                final movie = state.movie;
                                final watchlistCubit = context
                                    .read<WatchlistCubit>();
                                final isSaved = watchlistCubit.isInWatchlist(
                                  movie,
                                );

                                return IconButton(
                                  icon: Icon(
                                    isSaved
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (isSaved) {
                                      watchlistCubit.removeMovie(movie);
                                    } else {
                                      watchlistCubit.addMovie(movie);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Play button
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              downloadMovie(state.movie.torrents![0].url!);
                            },
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ),

                      // نص اسفل الصورة
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                state.movie.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.movie.year.toString(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Watch button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 58,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Watch",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Stats row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildStat(
                          Icons.favorite,
                          state.movie.rating.toString(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStat(
                          Icons.access_time,
                          state.movie.runtime.toString(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStat(
                          Icons.star,
                          state.movie.rating.toString(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Similar Movies title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Similar Movies',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Similar Movies list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.similarMovies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.5),
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        rating: state.similarMovies[index].rating ?? 5,
                        imagePath: state.similarMovies[index].mediumCoverImage!,
                        movieID: state.similarMovies[index].id!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Summary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.movie.summary ?? 'No summary available.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Loader while fetching
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xffF6BD00), size: 30),
          const SizedBox(width: 14),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
