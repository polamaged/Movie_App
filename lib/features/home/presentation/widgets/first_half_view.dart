import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/widgets/custom_error_widget.dart';
import 'package:movies_app/features/home/presentation/cubits/highratedmovies/highratedmovies_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';

class FirstHalfView extends StatefulWidget {
  const FirstHalfView({super.key});

  @override
  State<FirstHalfView> createState() => _FirstHalfViewState();
}

class _FirstHalfViewState extends State<FirstHalfView> {
  late PageController _controller;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8)
      ..addListener(() {
        setState(() {
          _currentPage = _controller.page!;
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
    return BlocBuilder<HighratedmoviesCubit, HighratedmoviesState>(
      builder: (context, state) {
        if (state is HighratedmoviesFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }
        if (state is HighratedmoviesSuccess) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(child: Text("No movies found."));
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              // Background blur حسب الصفحة الحالية
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.network(
                    movies[_currentPage.round()].largeCoverImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // PageView للأفلام
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    double diff = (_currentPage - index).abs();
                    double scale = 1 - (diff * 0.2);
                    if (scale < 0.8) scale = 0.8;

                    return Center(
                      child: Transform.scale(
                        scale: scale,
                        child: MovieCard(
                          rating: movies[index].rating ?? 0.0,
                          imagePath: movies[index].largeCoverImage!,
                          movieID: movies[index].id!,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        // Loader أثناء التحميل
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}