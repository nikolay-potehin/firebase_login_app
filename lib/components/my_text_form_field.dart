import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    this.validator = FormValidator.validateDefault,
    this.hintText = '',
    this.obscureText = false,
    this.hideButton = false,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool hideButton;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: false,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        helperText: "",
        labelText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(fontSize: 16),
        labelStyle: const TextStyle(fontSize: 0),
        suffixIcon: widget.hideButton
            ? IconButton(
                onPressed: () => setState(() {
                  obscureText = !obscureText;
                }),
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: myPrimarySwatch,
                ),
              )
            : null,
      ),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[/\\ ]'))],
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
