import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/utils.dart';

class MessagingRepository {
  static Future<bool> sendMessage(MessageData messageData) async {
    final recipientExists = await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((collection) => collection.docs.indexWhere(
                (element) => element.id == messageData.toUser.email)) !=
        -1;

    if (!recipientExists) {
      Utils.showSnackBar('Such user doesn\'t exists');
      return false;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(messageData.fromUser.email)
        .collection('sendedMessages')
        .add(MessageData.asSended(messageData).toJson());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(messageData.toUser.email)
        .collection('receivedMessages')
        .add(messageData.toJson());

    Utils.showSnackBar('Message sent to "${messageData.toUser.email}"');
    return true;
  }
}
