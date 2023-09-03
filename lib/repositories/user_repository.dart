import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/models/utils.dart';

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
      await _updateUser();
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Authentication failed, please try again later');
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
      user?.updateDisplayName(displayName);
      _setUser();

      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Registration failed, please try again later');
      return false;
    }
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message ??
          'Couldn\'t send password reset email, please try again later');
      return false;
    }
  }

  static Future<bool> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message ??
          'Couldn\'t send password reset email, please try again later');
      return false;
    }
  }

  static Future<void> reload() async {
    if (user == null) return;

    try {
      await FirebaseAuth.instance.currentUser!.reload();
      await _updateUser();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Couldn\'t reload user, please try again later');
    }
  }

  static Future<void> _setUser() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.email).set({
      'email': user!.email,
      'displayName': user!.displayName,
      'lastSignInTime': user!.metadata.lastSignInTime,
      'creationTime': user!.metadata.creationTime,
    });
  }

  static Future<void> _updateUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .update({
        'lastSignInTime': user!.metadata.lastSignInTime,
      });
    } on FirebaseException catch (e) {
      logout();
      Utils.showSnackBar(e.message ?? 'Couldn\'t find user, please login');
    }
  }
}
