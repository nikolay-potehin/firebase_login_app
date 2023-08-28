import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepository {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> setUser(User user) async {
    if (!user.emailVerified) return;

    await firestore.collection('users').doc(user.uid).set({
      'email': user.email,
      'displayName': user.displayName,
      'lastSignInTime': user.metadata.lastSignInTime,
      'creationTime': user.metadata.creationTime,
    });
  }
}
