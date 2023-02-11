import 'dart:math';

import 'package:simpleproject/services/auth/auth_exceptions.dart';
import 'package:simpleproject/services/auth/auth_provider.dart';
import 'package:simpleproject/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });
    test('Cannot logout if not intialized', () {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test('Should be able to intialize', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });
    test('Should be to test within 2 seconds', (() async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }), timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to login function', () async {
      final badUser =  provider.createUser(
          email: 'anzjo@gmail.com', password: 'password');
      expect(badUser, throwsA(const TypeMatcher<UserNotfoundAuthException>()));

      final badPassword =
           provider.createUser(email: 'anz@gmail.com', password: 'anzjo');
      expect(badPassword,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));
      final user = await provider.createUser(email: 'anz', password: 'jo');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('Logged in user should be able to get verified', (() {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    }));
    test('Should be able to logIn and logOut', () {
      provider.logOut();
      provider.logIn(email: "email", password: "password");
    });
    final user = provider.currentUser;
    expect(user, isNotNull);
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 2));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == "anzjo@gmail.com") throw UserNotfoundAuthException();
    if (password == "anzjo") throw WrongPasswordAuthException();
    final user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotfoundAuthException();
    final newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
