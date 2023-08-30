import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/models/message_data.dart';

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

  static Future<void> sendMessage(MessageData messageData) async {
    final recipientExists = await firestore.collection('users').get().then(
            (collection) => collection.docs
                .indexWhere((element) => element.id == messageData.toEmail)) !=
        -1;

    if (!recipientExists) {
      // TODO: implement error, such user doesn't exist
      return;
    }

    firestore
        .collection('users')
        .doc(messageData.toEmail)
        .collection('messages')
        .add(
          messageData.toJson(),
        );
  }
}
