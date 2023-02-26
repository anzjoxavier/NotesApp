import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState(
      {required this.isLoading, this.loadingText = "please wait a moment"});
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut(
      {required this.exception, required bool isLoading, String? loadingText})
      : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateUnintialized extends AuthState {
  const AuthStateUnintialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateForgetPassword extends AuthState {
  final Exception? exception;
  final bool hasSendEmail;

const AuthStateForgetPassword({
  required this.exception,
  required this.hasSendEmail,
  required bool isLoading}) : super(isLoading: isLoading);
  
}
