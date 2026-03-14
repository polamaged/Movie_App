part of 'highratedmovies_cubit.dart';

abstract class HighratedmoviesState extends Equatable {
  const HighratedmoviesState();

  @override
  List<Object> get props => [];
}

class HighratedmoviesInitial extends HighratedmoviesState {}
class HighratedmoviesLoading extends HighratedmoviesState {}
class HighratedmoviesSuccess extends HighratedmoviesState {
  final List<MovieModel> movies;
  const HighratedmoviesSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
 }
class HighratedmoviesFailure extends HighratedmoviesState {
  final String errMessage;
  const HighratedmoviesFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}



