part of 'watchlist_cubit.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistUpdated extends WatchlistState {
  final List<MovieModel> movies;
  const WatchlistUpdated(this.movies);

  @override
  List<Object> get props => [movies];
}
