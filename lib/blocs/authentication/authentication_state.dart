part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

/// App just started
class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

/// Login made with success
class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();
}

/// User Logged out
class AuthenticationRevoked extends AuthenticationState {
  const AuthenticationRevoked();
}

/// Loading (awaitng for register/login response)
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}
