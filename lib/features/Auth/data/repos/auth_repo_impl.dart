import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/errors/exception.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/core/services/data_base_service.dart';
import 'package:movies_app/core/services/firebase_auth_service.dart';
import 'package:movies_app/core/utils/backend_endpoint.dart';
import 'package:movies_app/features/Auth/data/models/user_models.dart';
import 'package:movies_app/features/Auth/domain/enities/user_enitiy.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo{
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;



  AuthRepoImpl({required this.firebaseAuthService, required this.databaseService});

  @override
  Future<void> addUserData({required UserEntity user})async{
      await databaseService.addData(
      collectionPath: BackendEndpoint.addUserDate,
      data: UserModels.fromEntity(user).toMap(),
      documentid: user.id,
    );
    
    
  }

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(String email, String password, String name, int phoneNumber, String avatar)async {
    User? user;

    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userentity = UserEntity(id: user.uid, name: name, email: email, phoneNumber: phoneNumber, avatar: avatar);

      await addUserData(user: userentity);
      return Right(userentity);

    }on CustomException catch (e) {
      await DeleteUser(user);
      return Left(ServerFailure(errMessage: e.message));
    }catch (e) {
      await DeleteUser(user);
      log(
        'exception in Authrepo.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return Left(ServerFailure(errMessage: 'An unknown error occurred.'));
    }
    
  }

  @override
  Future<UserEntity> getUserData({required String id}) async {
     var UserData = await databaseService.getData(
      path: BackendEndpoint.getUserDate,
      documentid: id,
    );

    return UserModels.fromJson(UserData);
  }

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    //   var jsondata = jsonEncode(UserModels.fromEntity(user).toMap());

    // await prefs.SetString(KUserData, jsondata);
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(String email, String password)async {
     try {
      
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("Auth state changed: $user");
      var UserEntity = await getUserData(id: user.uid);
      await saveUserData(user: UserEntity);
      return right(UserEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log('exception in Authrepo.signInWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(errMessage: 'An unknown error occurred'));
    }
    
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

    Future<void> DeleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteCurrentUser();
    }
  }
  
  @override
  Future<void> resetPassword(String email) async {
      await firebaseAuthService.sendPasswordResetEmail(email: email);
  }
  
  @override
  Future<void> signOut() async{
    await firebaseAuthService.signOut();
  }
  
  @override
  Future<void> deleteProfile() {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

}