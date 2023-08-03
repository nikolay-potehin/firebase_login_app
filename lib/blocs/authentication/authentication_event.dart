part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

/// User Logged In
class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

/// User Logged Out
class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
