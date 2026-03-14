part of 'moviesbygenre_cubit.dart';

abstract class MoviesbygenreState extends Equatable {
  const MoviesbygenreState();

  @override
  List<Object> get props => [];
}

class MoviesbygenreInitial extends MoviesbygenreState {}
class MoviesbygenreLoading extends MoviesbygenreState {}
class MoviesbygenreSuccess extends MoviesbygenreState {
  final List<MovieModel>movies;
  const MoviesbygenreSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}
class MoviesbygenreFailure extends MoviesbygenreState {
  final String errMessage;
  const MoviesbygenreFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}


