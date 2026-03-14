import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/features/Auth/domain/enities/user_enitiy.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

    Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);

    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.toString())),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

    Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.toString())),
      (user) => emit(LoginSuccess(user: user)),
    );
  }
  
  Future<void> signOut() async {
    await authRepo.signOut();
    emit(LoginInitial());
  }

    

}
