import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

part 'deatilsmovie_state.dart';

class DeatilsmovieCubit extends Cubit<DeatilsmovieState> {
  DeatilsmovieCubit(this.homeRepo) : super(DeatilsmovieInitial());
  final HomeRepo homeRepo;
Future<void> fetchMoviesbyID(int movieID) async {
  emit(DeatilsmovieLoading());

  try {
    // جلب بيانات الفيلم الرئيسي
    var result = await homeRepo.fetchMoviesbyID(movieID);

    result.fold(
      (failure) {
        emit(DeatilsmovieFailure(errMessage: failure.errMessage));
      },
      (movie) async {
        // جلب Similar Movies
        final similarMoviesResult = await homeRepo.getSimilarMovies(movieID);

        List<MovieModel> similarMovies = [];
        similarMoviesResult.fold(
          (_) => similarMovies = [],      // لو فشل fetch
          (movies) => similarMovies = movies ?? [],  // لو null حط List فاضية
        );

        emit(DeatilsmovieSuccess(movie: movie, similarMovies: similarMovies));
      },
    );
  } catch (e) {
    emit(DeatilsmovieFailure(errMessage: e.toString()));
  }
}
  
}
