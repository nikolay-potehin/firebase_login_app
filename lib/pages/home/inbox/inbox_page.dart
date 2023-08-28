import 'package:firebase_login_app/components/my_error_widget.dart';
import 'package:firebase_login_app/models/app_data.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: deleteMessages,
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Center(
          child: FutureBuilder(
            future: AppData.messages,
            initialData: const <MessageData>[],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      snapshot.data![index].asWidget(context),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                );
              }

              if (snapshot.hasError) {
                return MyErrorWidget(message: snapshot.error.toString());
              }

              return const SizedBox();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendMessage,
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }

  Future<void> refresh() async {
    AppData.reloadMessages();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() {});
  }

  void sendMessage() async {
    await AppData.sendMessage();
    AppData.reloadMessages();
    if (mounted) setState(() {});
  }

  void deleteMessages() async {
    await AppData.deleteMessages();
    AppData.reloadMessages();
    if (mounted) setState(() {});
  }
}
