import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/get_it_service.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';
import 'package:movies_app/features/Auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt.get<AuthRepo>()),
      child: Scaffold(body: SafeArea(child: SignupViewBodyBlocConsumer())),
    );
  }
}