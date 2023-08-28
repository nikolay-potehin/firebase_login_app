import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/user_data.dart';

class FirestoreRepository {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> setUser(User user) async {
    await firestore.collection('users').doc(user.email).set({
      'email': user.email,
      'displayName': user.displayName,
      'lastSignInTime': user.metadata.lastSignInTime,
      'creationTime': user.metadata.creationTime,
    });
  }

  static Future<List<UserData>> readUsers() {
    return firestore.collection('users').get().then(
          (collection) => collection.docs
              .map((doc) => UserData.fromJson(doc.data()))
              .toList(),
        );
  }

  static Future<void> sendMessage({
    required String fromEmail,
    required String toEmail,
  }) async {
    final recipientExists = await firestore.collection('users').get().then(
            (collection) => collection.docs
                .indexWhere((element) => element.id == toEmail)) !=
        -1;

    if (!recipientExists) {
      // TODO: implement error, such user doesn't exist
      return;
    }

    return firestore
        .collection('users')
        .doc(toEmail)
        .collection('messages')
        .doc()
        .set(
          MessageData(
            fromEmail: fromEmail,
            toEmail: toEmail,
            title: 'New Message',
            content:
                'This is a message content. There you put your message basically.',
          ).toJson(),
        );
  }

  static Future<List<MessageData>> readMessages(User user) {
    return firestore
        .collection('users')
        .doc(user.email)
        .collection('messages')
        .get()
        .then((collection) => collection.docs
            .map((doc) => MessageData.fromJson(doc.data()))
            .toList())
        .then((value) {
      value.sort((a, b) => b.sendAtTime.compareTo(a.sendAtTime));
      return value;
    });
  }

  static Future<void> deleteMessages(User user) async {
    return firestore
        .collection('users')
        .doc(user.email)
        .collection('messages')
        .get()
        .then((collection) {
      for (final doc in collection.docs) {
        doc.reference.delete();
      }
    });
  }
}
