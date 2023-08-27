import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/form_validator.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            validator: FormValidator.validateEmail,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: resetPassword,
            child: const Text('RESET PASSWORD'),
          ),
        ],
      ),
    );
  }

  Future resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final email = emailController.text.trim();
    final successful =
        await context.read<UserRepository>().sendPasswordResetEmail(email);

    if (successful) {
      Utils.showSnackBar(
          'Reset password email has been send to "$email" successfuly');

      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      Navigator.of(context).pop();
    }
  }
}
