import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/models/users_model.dart';
import 'package:firebase_login_app/pages/home/write_message/user_info_card.dart';
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

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toUser = widget.toUser;

    return Scaffold(
      appBar: AppBar(title: const Text('New Message')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(user: toUser),
            const SizedBox(height: 10),
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
      toUser: widget.toUser,
      title: titleController.text.trim(),
      content: contentController.text.trim(),
      isUnread: true,
    );

    return MessagingRepository.sendMessage(message);
  }

  void _trySendMessage() async {
    // Remove onscreen keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final success = await Utils.showLoading(context, _sendMessage());

      if (success && mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
