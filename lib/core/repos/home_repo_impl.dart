import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/core/services/ApiService.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';
import 'package:movies_app/core/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, List<MovieModel>>> fetchHighRatedMovies() async {
    try {
      var data = await apiService.get(
        endpoint: 'list_movies.json?minimum_rating=8',
      );

      List<MovieModel> movies = [];
      for (var item in data['data']['movies']) {
        movies.add(MovieModel.fromJson(item));
      }

      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> fetchFeaturedMovies() async {
    try {
      var data = await apiService.get(endpoint: 'list_movies.json');

      List<MovieModel> movies = [];
      for (var item in data['data']['movies']) {
        movies.add(MovieModel.fromJson(item));
      }
      movies.shuffle();
      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> fetchMoviesbyGenre(
    String genre,
  ) async {
    try {
      var data = await apiService.get(
        endpoint: 'list_movies.json?genre=$genre',
      );

      List<MovieModel> movies = [];
      for (var item in data['data']['movies']) {
        movies.add(MovieModel.fromJson(item));
      }

      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieModel>> fetchMoviesbyID(int movieID) async {
    try {
      var data = await apiService.get(
        endpoint: 'movie_details.json?movie_id=$movieID',
      );

     var movieData = data['data']['movie']; 
      final movie = MovieModel.fromJson(movieData);

      return Right(movie);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<MovieModel>>> getSimilarMovies(int movieID) async{
     try {
      var data = await apiService.get(
        endpoint: 'movie_suggestions.json?movie_id=$movieID',
      );

      List<MovieModel> movies = [];
      for (var item in data['data']['movies']) {
        movies.add(MovieModel.fromJson(item));
      }

      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<MovieModel>>> getSearchMovies(String query)async {
      try {
        var data = await apiService.get(
          endpoint: 'list_movies.json?query_term=$query',
        );
  
        List<MovieModel> movies = [];
        for (var item in data['data']['movies']) {
          movies.add(MovieModel.fromJson(item));
        }
  
        return Right(movies);
      } catch (e) {
        return Left(ServerFailure(errMessage: e.toString()));
      }
  }
}
