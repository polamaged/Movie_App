import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/services/data_base_service.dart';
import 'package:movies_app/core/services/firebase_auth_service.dart';
import 'package:movies_app/features/Auth/data/models/user_models.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.firebaseAuthService, this.databaseService)
      : super(ProfileInitial());

  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  Future<void> getUserData() async {

    try {
      final uid = firebaseAuthService.getUserId();

      var data = await databaseService.getData(
        path: "users",
        documentid: uid,
      );

      if (data != null) {
        UserModels user = UserModels.fromJson(data);
        emit(ProfileUpdated(user));
      }
    } catch (e) {
      emit(ProfileInitial());
    }
  }

  
}