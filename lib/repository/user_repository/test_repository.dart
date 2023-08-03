import 'package:firebase_login_app/repository/user_repository.dart';

class TestUserRepository extends UserRepository {
  /// The email of the user
  final String fakeEmail;

  /// Determines whether the methods will fail or not
  final bool success;

  /// Mock authenticating repository (for testing)
  TestUserRepository({
    required this.fakeEmail,
    required this.success,
  });

  @override
  Future<bool> authenticate(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => success);
  }

  @override
  Future<bool> register(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => success);
  }

  @override
  Future<void> logOut() => Future.delayed(const Duration(seconds: 2));

  @override
  String get signedEmail => fakeEmail;
}
