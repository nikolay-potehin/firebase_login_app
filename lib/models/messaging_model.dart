import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_app/models/message_data.dart';
import 'package:firebase_login_app/models/utils.dart';

class MessagingModel {
  const MessagingModel();

  Future<bool> sendMessage(MessageData messageData) async {
    final recipientExists = await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((collection) => collection.docs
                .indexWhere((element) => element.id == messageData.toEmail)) !=
        -1;

    if (!recipientExists) {
      Utils.showSnackBar('Such user doesn\'t exists');
      return false;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(messageData.toEmail)
        .collection('messages')
        .add(messageData.toJson());

    Utils.showSnackBar('Message sent to "${messageData.toEmail}"');
    return true;
  }
}
