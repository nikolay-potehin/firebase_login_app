part of 'credentials_bloc.dart';

abstract class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

class CredentialsInitial extends CredentialsState {
  const CredentialsInitial();
}

class CredentialsLoginLoading extends CredentialsState {
  const CredentialsLoginLoading();
}

class CredentialsRegisterLoading extends CredentialsState {
  const CredentialsRegisterLoading();
}

class CredentialsLoginFailure extends CredentialsState {
  final String message;

  const CredentialsLoginFailure([String? errorMessage])
      : message = errorMessage ?? 'Login Failed';

  @override
  List<Object> get props => [message];
}

class CredentialsRegisterFailure extends CredentialsState {
  final String message;

  const CredentialsRegisterFailure([String? errorMessage])
      : message = errorMessage ?? 'Registration Failed';

  @override
  List<Object> get props => [message];
}
