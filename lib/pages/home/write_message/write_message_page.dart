import 'package:firebase_login_app/components/my_text_form_field.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/write_message/write_message_form.dart';
import 'package:firebase_login_app/repositories/messaging_repository.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class WriteMessagePage extends StatefulWidget {
  const WriteMessagePage({
    super.key,
    required this.toUser,
  });

  final UserData toUser;

  @override
  State<WriteMessagePage> createState() => _WriteMessagePageState();
}

class _WriteMessagePageState extends State<WriteMessagePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final fromEmailController = TextEditingController();
  final toEmailController = TextEditingController();

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
    final fromEmail = UserRepository.user!.email!;
    final toUser = widget.toUser;

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
              hintText: 'To: ${toUser.displayName} (${toUser.email})',
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
        onPressed: _trySendMessage,
        child: const Icon(Icons.send_rounded, color: Colors.white),
      ),
    );
  }

  Future<bool> _sendMessage() async {
    final currentUserDoc = await UsersModel.getUserByEmail(
      UserRepository.user!.email!,
    );

    final message = MessageData(
      fromUser: UserData.fromDocument(currentUserDoc),
      toEmail: widget.toUser.email,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      isUnread: true,
    );

    return MessagingRepository.sendMessage(message);
  }

  void _trySendMessage() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await Utils.showLoading(context, _sendMessage());

      if (success && mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
