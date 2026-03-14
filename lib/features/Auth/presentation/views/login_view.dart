import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/get_it_service.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';
import 'package:movies_app/features/Auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/Login_view_body_bloc_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(body: SafeArea(child: LoginViewBodyBlocConsumer())),
    );
  }
}
