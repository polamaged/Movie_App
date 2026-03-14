import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/services/ApiService.dart';
import 'package:movies_app/core/repos/home_repo_impl.dart';
import 'package:movies_app/core/services/data_base_service.dart';
import 'package:movies_app/core/services/firebase_auth_service.dart';
import 'package:movies_app/core/services/firestore_service.dart';
import 'package:movies_app/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';



final getIt = GetIt.instance;

void setup() {
     getIt.registerSingleton<ApiService>(ApiService(Dio()));
     getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(apiService: getIt<ApiService>()));

   getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
   getIt.registerSingleton<DatabaseService>(FireStoreService());
 getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}