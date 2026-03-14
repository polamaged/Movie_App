import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/firebase_auth_service.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_Text_form_field_withobs.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';
import 'package:movies_app/features/Auth/presentation/cubit/fogot_password_cubit/forgot_password_cubit.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppBar(title: 'Forgot Password'),
            Image.asset(Assets.imagesForgotPassword),
            CustomTextFormFieldWithObs(
              HintText: "Email",
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email, color: Colors.white),
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            CustomButtom(
              onPressed: () async {
                final email = _emailController.text.trim();
        
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your email")),
                  );
                  return;
                }
                 context.read<ForgotPasswordCubit>().sendResetEmail(
                   _emailController.text.trim(),
                 );
              },
              text: "Verify Email",
              color: AppColors.primaryColor,
              textColor: Colors.black,
              borderColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
