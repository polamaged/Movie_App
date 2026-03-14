import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/features/Auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading ? true : false,
          child:const LoginViewBody(),
        );
      },
      listener: (context, state) {
       if (state is LoginSuccess) {
          Navigator.pushNamed(context, RouteManager.home);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Login successfully')));
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
    },);
  }
}