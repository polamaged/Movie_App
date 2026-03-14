import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

part 'moviesbygenre_state.dart';

class MoviesbygenreCubit extends Cubit<MoviesbygenreState> {
  MoviesbygenreCubit(this.homeRepo) : super(MoviesbygenreInitial());

  final HomeRepo homeRepo;
  Future<void> fetchMoviesbyGenre({String genre = "Action"}) async {
    emit(MoviesbygenreLoading());
    var reult = await homeRepo.fetchMoviesbyGenre(genre);
    reult.fold(
      (failure) => emit(MoviesbygenreFailure(errMessage: failure.errMessage)),
      (movie) => emit(MoviesbygenreSuccess(movies: movie)),
    );

  }
  
}
