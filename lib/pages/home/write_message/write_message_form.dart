import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
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
          _FormTitle(context.localize(LocKeys.messageTopic)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 140),
            child: MyTextFormField(
              controller: titleController,
              hintText: context.localize(LocKeys.messageTopicHint),
              inputFormatters: const [],
              maxLines: null,
            ),
          ),
          _FormTitle(context.localize(LocKeys.messageContent)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: MyTextFormField(
              controller: contentController,
              hintText: context.localize(LocKeys.messageContentHint),
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
