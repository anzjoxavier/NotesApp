import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final bool isEmailVerified;
  final String?email;
  AuthUser({required this.email, required this.isEmailVerified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified, email: user.email);
}
