import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/services/data_base_service.dart';
import 'package:movies_app/core/services/firebase_auth_service.dart';
import 'package:movies_app/features/Auth/data/models/user_models.dart';

part 'editprofile_state.dart';

class EditprofileCubit extends Cubit<EditprofileState> {
  EditprofileCubit(this.databaseService, this.firebaseAuthService)
    : super(EditprofileInitial());
  final DatabaseService databaseService;
  final FirebaseAuthService firebaseAuthService;
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(EditprofileLoading());

    try {
      final uid = firebaseAuthService.getUserId();
       var data = await databaseService.getData(
      path: "users",
      documentid: uid,
    );

    UserModels oldUser = UserModels.fromJson(data);

      UserModels updatedUser = UserModels(
        id: oldUser.id,
        email: oldUser.email,
        name: name.isEmpty ? oldUser.name : name,
        phoneNumber: phone.isEmpty
          ? oldUser.phoneNumber
          : int.parse(phone),
           avatar: avatar,
      );

      await databaseService.updateData(
        path: "users",
        documentid: uid,
        data: updatedUser.toJson(),
      );

      emit(ProfileUpdated(updatedUser));
    } catch (e) {
      emit(EditprofileFailure(errMessage: (e.toString())));
    }
  }

  Future<UserModels> getUserData() async {
  final uid = firebaseAuthService.getUserId();

  var data = await databaseService.getData(
    path: "users",
    documentid: uid,
  );

  return UserModels.fromJson(data);
}
}
