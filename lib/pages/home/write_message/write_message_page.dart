import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_form.dart';
import 'package:firebase_login_app/repositories/messaging_repository.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

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
      final future = MessagingRepository.sendMessage(MessageData(
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
