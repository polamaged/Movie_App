import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/Auth/domain/enities/user_enitiy.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
    final AuthRepo authRepo;


   Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    int phoneNumber,
    String avatar,
  ) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email,
      password,
      name,
      phoneNumber,
      avatar,
    );

    result.fold(
      (failure) => emit(SignupFailure(errorMessage: failure.toString())),
      (user) => emit(SignupSuccess(user: user)),
    );
  }
}
