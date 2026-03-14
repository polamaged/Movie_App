import 'package:flutter/material.dart';

class CustomTextFormFieldWithObs extends StatelessWidget {
  const CustomTextFormFieldWithObs({
    super.key,
    required this.HintText,
    required this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.onSaved,
    this.obscureText = false,
    String? initialValue, 
    this.controller,
  });
  final String HintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon ,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xff282A28),
        hintText: HintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: Color(0xff282A28)),
    );
  }
}
