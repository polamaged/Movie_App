import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/features/Auth/presentation/cubit/fogot_password_cubit/forgot_password_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/forgot_password_view_body.dart';

class ForgotPasswordBlocConsumer extends StatelessWidget {
  const ForgotPasswordBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
         return ModalProgressHUD(
          inAsyncCall: state is ForgotPasswordLoading ? true : false,
          child:const ForgotPasswordViewBody(),
        );
    }, listener: (context, state) {
       if (state is ForgotPasswordSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Password reset successfully')));
        }
        if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      
    },);
  }
}