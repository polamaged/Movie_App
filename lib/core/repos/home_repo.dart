import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/core/model/movie_model/movie_model.dart';

abstract class HomeRepo {

 Future<Either<Failure, List<MovieModel>>> fetchHighRatedMovies();
 Future<Either<Failure, List<MovieModel>>> fetchFeaturedMovies();
 Future<Either<Failure, List<MovieModel>>> fetchMoviesbyGenre(String genre);
 Future<Either<Failure, MovieModel>> fetchMoviesbyID(int movieID); 
 Future<Either<Failure, List<MovieModel>>> getSimilarMovies(int movieID);
 Future<Either<Failure, List<MovieModel>>> getSearchMovies(String query);
}