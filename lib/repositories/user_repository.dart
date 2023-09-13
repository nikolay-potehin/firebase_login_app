import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/localization/app_localization.dart';
import 'package:firebase_login_app/utils.dart';

class UserRepository {
  static User? get user => FirebaseAuth.instance.currentUser;

  static Future<bool> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateUserDetails();
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(e.toLocKey());
      return false;
    }
  }

  static Future<bool> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user?.updateDisplayName(displayName);
      _setUserDetails();

      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(e.toLocKey());
      return false;
    }
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> delete() async {
    try {
      await _deleteUserDoc();
      await FirebaseAuth.instance.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      FirebaseAuth.instance.signOut();
      Utils.showMessage(e.toLocKey());
    }
  }

  static Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(e.toLocKey());
      return false;
    }
  }

  static Future<bool> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(e.toLocKey());
      return false;
    }
  }

  static Future<void> reload() async {
    if (user == null) return;

    try {
      await FirebaseAuth.instance.currentUser!.reload();
      await _updateUserDetails();
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(e.toLocKey());
    }
  }

  static Future<void> _deleteUserDoc() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .delete();
  }

  static Future<void> _setUserDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.email).set({
      'email': user!.email,
      'displayName': user!.displayName,
      'lastSignInTime': user!.metadata.lastSignInTime,
      'creationTime': user!.metadata.creationTime,
    });
  }

  static Future<void> _updateUserDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .update({
        'lastSignInTime': user!.metadata.lastSignInTime,
        'isEmailVerified': user!.emailVerified,
      });
    } on FirebaseException catch (e) {
      logout();
      Utils.showMessage(e.toLocKey());
    }
  }
}
