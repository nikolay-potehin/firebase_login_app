import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/messaging_model.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteMessagePage extends StatefulWidget {
  const WriteMessagePage({
    super.key,
    required this.userDoc,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> userDoc;

  @override
  State<WriteMessagePage> createState() => _WriteMessagePageState();
}

class _WriteMessagePageState extends State<WriteMessagePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final fromEmailController = TextEditingController();
  final toEmailController = TextEditingController();
  late final String fromEmail;
  late final String fromDisplayName;
  late final String toEmail;
  late final String toDisplayName;

  @override
  void initState() {
    fromEmail = UserRepository.user!.email!;
    fromDisplayName = UserRepository.user!.displayName!;
    toEmail = widget.userDoc.get('email');
    toDisplayName = widget.userDoc.get('displayName');
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    fromEmailController.dispose();
    toEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Message')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextFormField(
              controller: fromEmailController,
              hintText: 'From: You ($fromEmail)',
              enabled: false,
            ),
            MyTextFormField(
              controller: fromEmailController,
              hintText: 'To: $toDisplayName ($toEmail)',
              enabled: false,
            ),
            WriteMessageForm(
              formKey: _formKey,
              titleController: titleController,
              contentController: contentController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _sendMessage(context),
        child: const Icon(Icons.send_rounded, color: Colors.white),
      ),
    );
  }

  _sendMessage(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final future = context.read<MessagingModel>().sendMessage(MessageData(
            fromEmail: fromEmail,
            toEmail: toEmail,
            title: titleController.text.trim(),
            content: contentController.text.trim(),
          ));

      final success = await Utils.showLoading(context, future);
      if (success && mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}

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
          const _Title('Topic'),
          MyTextFormField(
            controller: titleController,
            hintText: 'Message topic',
            inputFormatters: const [],
            maxLines: 1,
          ),
          const _Title('Message'),
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

class _Title extends StatelessWidget {
  const _Title(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
      child:
          Text(text, style: const TextStyle(fontSize: 20, letterSpacing: 1.5)),
    );
  }
}
