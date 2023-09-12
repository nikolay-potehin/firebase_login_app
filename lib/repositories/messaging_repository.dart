import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/utils.dart';

class MessagingRepository {
  static Future<bool> sendMessage(MessageData messageData) async {
    final recipientExists = await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((collection) => collection.docs.indexWhere(
                (element) => element.id == messageData.toUser.email)) !=
        -1;

    if (!recipientExists) {
      Utils.showMessage(LocKeys.onSuchUserDoesntExist);
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

    Utils.showMessage(LocKeys.messageSentSuccessfully);
    return true;
  }

  static Future<void> deleteMessages(
      List<DocumentSnapshot<Map<String, dynamic>>> messagesDocs) {
    final batch = FirebaseFirestore.instance.batch();

    for (final messageDoc in messagesDocs) {
      batch.delete(messageDoc.reference);
    }

    return batch.commit();
  }
}
