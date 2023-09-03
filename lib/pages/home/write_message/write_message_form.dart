import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:flutter/material.dart';

class WriteMessageForm extends StatelessWidget {
  const WriteMessageForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.titleController,
    required this.contentController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _FormTitle('Topic'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 140),
            child: MyTextFormField(
              controller: titleController,
              hintText: 'Message topic',
              inputFormatters: const [],
              maxLines: null,
            ),
          ),
          const _FormTitle('Message'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: MyTextFormField(
              controller: contentController,
              hintText: 'Message content',
              inputFormatters: const [],
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
      child:
          Text(text, style: const TextStyle(fontSize: 20, letterSpacing: 1.5)),
    );
  }
}
