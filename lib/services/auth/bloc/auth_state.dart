import 'package:flutter/foundation.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoginFailed extends AuthState {
  final Exception exception;
  const AuthStateLoginFailed(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}


class AuthStateLoggedOut extends AuthState{
  const AuthStateLoggedOut();
}

class AuthStateLogOutFailed extends AuthState {
  final Exception exception;
  const AuthStateLogOutFailed(this.exception);
}


