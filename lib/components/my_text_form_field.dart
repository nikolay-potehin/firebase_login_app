import 'package:firebase_login_app/models/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    this.validator = FormValidator.validateDefault,
    this.hintText = '',
    this.obscureText = false,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))],
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
