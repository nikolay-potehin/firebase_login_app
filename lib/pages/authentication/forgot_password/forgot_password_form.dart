import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:firebase_login_app/utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextFormField(
            controller: emailController,
            hintText: context.localize(LocKeys.email),
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) => FormValidator.validateEmail(context, value),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: resetPassword,
            child: Text(context.localize(LocKeys.resetPassword).toUpperCase()),
          ),
        ],
      ),
    );
  }

  Future resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text;

    final success = await Utils.showLoading(
      context,
      UserRepository.sendPasswordResetEmail(email),
    );

    if (success && mounted) {
      Utils.showMessage(LocKeys.resetPasswordEmailHasBeenSentSuccessfully);

      Navigator.of(context).pop();
    }
  }
}
