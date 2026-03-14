import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

part 'moviesearch_state.dart';

class MoviesearchCubit extends Cubit<MoviesearchState> {
  MoviesearchCubit(this.homeRepo) : super(MoviesearchInitial());
    final HomeRepo homeRepo;

  Future<void> fetchSearchMovies(String query) async {
    emit(MoviesearchLoading());
    var result = await homeRepo.getSearchMovies(query);
    result.fold(
      (failure) => emit(MoviesearchFailure(errMessage: failure.errMessage)),
      (movies) => emit(MoviesearchSuccess(movies: movies)),
    );
  }

  
}
