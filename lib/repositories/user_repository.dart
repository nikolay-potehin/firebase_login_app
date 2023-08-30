import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/models/utils.dart';
import 'package:firebase_login_app/repositories/firestore_repository.dart';

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
      await FirestoreRepository.setUser(user!);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Couldn\'t reload user, please try again later');
    }
  }
}
