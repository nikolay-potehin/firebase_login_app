import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_login_app/blocs/authentication/authentication_bloc.dart';
import 'package:firebase_login_app/repository/user_repository.dart';
import 'package:flutter/services.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  CredentialsBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(const CredentialsInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<CredentialsState> emit) async {
    emit(const CredentialsLoginLoading());

    try {
      final success = await userRepository.authenticate(
        event.username,
        event.password,
      );

      if (success) {
        authenticationBloc.add(const LoggedIn());
      } else {
        emit(const CredentialsLoginFailure());
      }

      emit(const CredentialsInitial());
    } on PlatformException {
      emit(const CredentialsLoginFailure());
    }
  }

  void _onRegisterButtonPressed(
      RegisterButtonPressed event, Emitter<CredentialsState> emit) async {
    emit(const CredentialsRegisterLoading());

    try {
      final success = await userRepository.register(
        event.username,
        event.password,
      );

      if (success) {
        authenticationBloc.add(const LoggedIn());
      } else {
        emit(const CredentialsRegisterFailure());
      }

      emit(const CredentialsInitial());
    } on PlatformException {
      emit(const CredentialsRegisterFailure());
    }
  }
}
