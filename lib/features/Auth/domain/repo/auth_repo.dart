import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/Auth/domain/enities/user_enitiy.dart';

abstract class AuthRepo {
 Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    int phoneNumber, String avatar,
  );  

    Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

    Future<Either<Failure, UserEntity>> signInWithGoogle();
   Future<void> addUserData({required UserEntity user});
  Future<void> saveUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String id});

  Future<void> resetPassword(String email);

Future<void> signOut();
Future<void> deleteProfile();
}