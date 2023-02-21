import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventIntialize extends AuthEvent {
  const AuthEventIntialize();
}

class AuthEventLogIn extends AuthEvent {
  final String Email;
  final String Password;
  const AuthEventLogIn(this.Email, this.Password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
