import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_images.dart';
import 'package:movies_app/core/widgets/custom_Text_form_field_withobs.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_buttom.dart';
import 'package:movies_app/core/widgets/password_field.dart';
import 'package:movies_app/features/Auth/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:movies_app/features/Auth/presentation/views/widgets/avatar_sector.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, username, password;
  late int phoneNumber;
  String selectedAvatar = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [   
            CustomAppBar(title: "Register",),
          const SizedBox(height: 20,),  
            AvatarSelector(onAvatarSelected: (avatarPath) {
              setState(() {
                selectedAvatar = avatarPath;
              });
              
            },),
          const SizedBox(height: 30,),
          CustomTextFormFieldWithObs(HintText: "Username", textInputType: TextInputType.text,obscureText: false,onSaved: (value) {
              username = value!;
            },prefixIcon: Icon(Icons.person,color: Colors.white,),),
          const SizedBox(height: 20),
          CustomTextFormFieldWithObs(HintText: "Email", textInputType: TextInputType.emailAddress,obscureText: false,onSaved: (value) {
              email = value!;
            },prefixIcon: Icon(Icons.email,color: Colors.white,),),
          const SizedBox(height: 20),
          PasswordField(prefixIcon: Icon(Icons.lock,color: Colors.white,),
          onSaved: (value) {
              password = value!;
          },),
          const SizedBox(height: 20),
          CustomTextFormFieldWithObs(HintText: "Phone Number", textInputType: TextInputType.phone,obscureText: false,onSaved: (value) {
               phoneNumber = int.parse(value!);
            },prefixIcon: Icon(Icons.phone,color: Colors.white,),), 
          const SizedBox(height: 20),
          CustomButtom(onPressed: () {
              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                context.read<SignupCubit>().createUserWithEmailAndPassword(
                      email,
                      password,
                      username,
                      phoneNumber,
                      selectedAvatar,
                    );  
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
          }, text: "Create Account", color: AppColors.primaryColor, textColor: Colors.black, borderColor: AppColors.primaryColor),
        
            SizedBox(height: 20),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Already have an account ?", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("Login", style: TextStyle(color: AppColors.primaryColor, fontSize: 16, decoration: TextDecoration.none),))
            ],)
          ],
        ),
      ),
    );
  }
}