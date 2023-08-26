import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/utils.dart';

class UserRepository {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<bool> authenticate(String username, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Authentication failed, please try again later');
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'Registration failed, please try again later');
      return false;
    }
  }

  Future<void> logOut() => FirebaseAuth.instance.signOut();

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
          e.message ?? 'An error occured in process, please try again later');
      return false;
    }
  }
}
