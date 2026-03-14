import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/get_it_service.dart';
import 'package:movies_app/features/Auth/domain/repo/auth_repo.dart';
import 'package:movies_app/features/Auth/presentation/cubit/fogot_password_cubit/forgot_password_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/forgot_password_bloc_consumer.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(getIt.get<AuthRepo>()),
      child: Scaffold(body: SafeArea(child: ForgotPasswordBlocConsumer())),
    );
  }
}
