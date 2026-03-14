import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

part 'highratedmovies_state.dart';

class HighratedmoviesCubit extends Cubit<HighratedmoviesState> {
  HighratedmoviesCubit(this.homeRepo) : super(HighratedmoviesInitial());

  final HomeRepo homeRepo; 

  Future<void> fetchHighRatedMovies() async
  {
    emit(HighratedmoviesLoading());
  var result = await homeRepo.fetchHighRatedMovies();
  result.fold(
    (failure) => emit(HighratedmoviesFailure(errMessage: failure.errMessage)),
    (movie) => emit(HighratedmoviesSuccess(movies: movie)),
  );
  }
}