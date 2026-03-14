part of 'moviesearch_cubit.dart';

abstract class MoviesearchState extends Equatable {
  const MoviesearchState();

  @override
  List<Object> get props => [];
}

class MoviesearchInitial extends MoviesearchState {}

class MoviesearchLoading extends MoviesearchState {}
class MoviesearchSuccess extends MoviesearchState {
  final List<MovieModel> movies;
  const MoviesearchSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}
class MoviesearchFailure extends MoviesearchState {
  final String errMessage;
  const MoviesearchFailure({required this.errMessage}); 
  @override
  List<Object> get props => [errMessage];
}


