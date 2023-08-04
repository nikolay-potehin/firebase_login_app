import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<void> authenticate(String username, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
  }

  Future<void> register(String username, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
  }

  Future<void> logOut() => FirebaseAuth.instance.signOut();
}
