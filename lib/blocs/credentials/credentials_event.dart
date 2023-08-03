part of 'credentials_bloc.dart';

abstract class CredentialsEvent extends Equatable {
  final String username;
  final String password;

  const CredentialsEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LoginButtonPressed extends CredentialsEvent {
  const LoginButtonPressed({
    required String username,
    required String password,
  }) : super(username, password);
}

class RegisterButtonPressed extends CredentialsEvent {
  const RegisterButtonPressed({
    required String username,
    required String password,
  }) : super(username, password);
}
