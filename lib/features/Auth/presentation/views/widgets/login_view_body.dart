import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_Text_form_field_withobs.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';
import 'package:movies_app/core/widgets/password_field.dart';
import 'package:movies_app/features/Auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/or-divider.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
          const    SizedBox(height: 50),
              Image.asset(Assets.imagesLogo, width: 150, height: 150),
          const    SizedBox(height: 60),
              CustomTextFormFieldWithObs(HintText: "Email", textInputType: TextInputType.emailAddress,obscureText: false,onSaved: (value) {
              email = value!;
            },prefixIcon: Icon(Icons.email,color: Colors.white,),),
              const SizedBox(height: 20),
              PasswordField(prefixIcon: Icon(Icons.lock,color: Colors.white,),onSaved: (value) {
                password = value!;
              },),
          
          const  SizedBox(height: 20),
          
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, RouteManager.forgotPassword);
                }, child: const Text("Forgot Password ?", style: TextStyle(color: AppColors.primaryColor, fontSize: 16, decoration: TextDecoration.none),))
              ],
            ),
            const SizedBox(height: 20),
            CustomButtom(onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
               context.read<LoginCubit>().signInWithEmailAndPassword(
                      email,
                      password,
                    );  // Perform login action with email and password
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            }, text: "Login", color: AppColors.primaryColor, textColor: Colors.black, borderColor: AppColors.primaryColor),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const Text("Don't have an account ?", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, RouteManager.signup);
                }, child: Text("Create One", style: TextStyle(color: AppColors.primaryColor, fontSize: 16, decoration: TextDecoration.none),))
              ],
            ),
           const SizedBox(height: 20),
            Ordivider(),
          const SizedBox(height: 20),
          
          CustomButtom(onPressed:() {
            
          } , text: "Login with Google",color: AppColors.primaryColor, textColor: Colors.black, borderColor: AppColors.primaryColor)
                
          
          
          ],
          
              ),
        ),
      ));
  }
}