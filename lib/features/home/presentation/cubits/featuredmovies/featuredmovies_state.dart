part of 'featuredmovies_cubit.dart';

abstract class FeaturedmoviesState extends Equatable {
  const FeaturedmoviesState();

  @override
  List<Object> get props => [];
}

class FeaturedmoviesInitial extends FeaturedmoviesState {}
class FeaturedmoviesLoading extends FeaturedmoviesState {}
class FeaturedmoviesSuccess extends FeaturedmoviesState {
  final List<MovieModel> movies;
  const FeaturedmoviesSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}
class FeaturedmoviesFailure extends FeaturedmoviesState {
  final String errMessage;
  const FeaturedmoviesFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

