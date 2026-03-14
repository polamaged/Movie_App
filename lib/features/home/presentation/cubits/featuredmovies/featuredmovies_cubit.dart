import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

part 'featuredmovies_state.dart';

class FeaturedmoviesCubit extends Cubit<FeaturedmoviesState> {
  FeaturedmoviesCubit(this.homeRepo) : super(FeaturedmoviesInitial());

  final HomeRepo homeRepo; 

  Future<void> fetchFeaturedMovies() async
  {
    emit(FeaturedmoviesLoading());
  var result = await homeRepo.fetchFeaturedMovies();
  result.fold(
    (failure) => emit(FeaturedmoviesFailure(errMessage: failure.errMessage)),
    (movie) => emit(FeaturedmoviesSuccess(movies: movie)),
  );
  }
  
}
