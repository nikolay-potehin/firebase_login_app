import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_data.dart';
import 'package:firebase_login_app/repositories/firestore_repository.dart';
import 'package:firebase_login_app/repositories/user_repository.dart';

class AppData {
  static Future<List<UserData>> users = FirestoreRepository.readUsers();
  static void reloadUsers() => users = FirestoreRepository.readUsers();

  static Future<List<MessageData>> messages = FirestoreRepository.readMessages(
    UserRepository.user!,
  );
  static void reloadMessages() => messages = FirestoreRepository.readMessages(
        UserRepository.user!,
      );

  static Future<void> sendMessage() async {
    await FirestoreRepository.sendMessage(UserRepository.user!);
  }

  static Future<void> deleteMessages() async {
    await FirestoreRepository.deleteMessages(UserRepository.user!);
  }
}
