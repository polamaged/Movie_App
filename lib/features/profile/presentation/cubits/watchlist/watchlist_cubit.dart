import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistInitial());
final List<MovieModel> _movies = [];

 List<MovieModel> get movies => List.unmodifiable(_movies);
  
  void addMovie(MovieModel movie) {
    if (!_movies.any((m) => m.id == movie.id)) {
      _movies.add(movie);
      emit(WatchlistUpdated(List.unmodifiable(_movies)));
    }
  }


    void removeMovie(MovieModel movie) {
    _movies.removeWhere((m) => m.id == movie.id);
    emit(WatchlistUpdated(List.unmodifiable(_movies)));
  }
   bool isInWatchlist(MovieModel movie) {
    return _movies.any((m) => m.id == movie.id);
  }
  
}
