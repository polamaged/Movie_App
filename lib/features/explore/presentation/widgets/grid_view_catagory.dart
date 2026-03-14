import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_error_widget.dart';
import 'package:movies_app/features/explore/presentation/cubits/moviesbygenre/moviesbygenre_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';

class GridViewCatagory extends StatelessWidget {
  const GridViewCatagory({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesbygenreCubit, MoviesbygenreState>(
      builder: (context, state) {
        if (state is MoviesbygenreFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }
        if (state is MoviesbygenreSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio:
                  MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
            ),
            itemBuilder: (context, index) {
              return MovieCard(rating: state.movies[index].rating ?? 5, imagePath: state.movies[index].mediumCoverImage!,movieID: state.movies[index].id!,);
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
