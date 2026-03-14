import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());
final AuthRepo authRepo;
    Future<void> sendResetEmail(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await authRepo.resetPassword(email);
      emit(ForgotPasswordSuccess(message: 'Password reset email sent to $email'));
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordFailure(errorMessage: e.code));
    } catch (e) {
      emit(ForgotPasswordFailure(errorMessage: e.toString()));
    }
  }
}
