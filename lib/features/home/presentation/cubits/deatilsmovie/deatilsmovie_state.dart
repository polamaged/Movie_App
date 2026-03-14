part of 'deatilsmovie_cubit.dart';

abstract class DeatilsmovieState extends Equatable {
  const DeatilsmovieState();

  @override
  List<Object> get props => [];
}

class DeatilsmovieInitial extends DeatilsmovieState {}
class DeatilsmovieLoading extends DeatilsmovieState {}
class DeatilsmovieSuccess extends DeatilsmovieState {
  final MovieModel movie;
  final List<MovieModel> similarMovies;

  
  const DeatilsmovieSuccess({required this.movie, required this.similarMovies});
    @override
  List<Object> get props => [movie, similarMovies];
}
class DeatilsmovieFailure extends DeatilsmovieState {
  final String errMessage;
  const DeatilsmovieFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}


