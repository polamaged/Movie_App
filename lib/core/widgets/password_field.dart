import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_Text_form_field_withobs.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved, this.prefixIcon});
  final void Function(String?)? onSaved;
   final Widget? prefixIcon;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldWithObs(
      obscureText: obscureText,
      onSaved: (value) {
        widget.onSaved?.call(value);
      },
      HintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      prefixIcon: widget.prefixIcon,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.remove_red_eye : Icons.visibility_off,
          color: const Color(0xFFC9CECF),
        ),
      ),
    );
  }
}
