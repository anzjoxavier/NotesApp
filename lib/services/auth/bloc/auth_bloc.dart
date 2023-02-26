import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simpleproject/services/auth/auth_provider.dart';
import 'package:simpleproject/services/auth/bloc/auth_event.dart';
import 'package:simpleproject/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUnintialized(isLoading: true)) {
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventIntialize>(((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    }));
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(email: email, password: password);
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateRegistering(isLoading: false, exception: e));
        }
      },
    );
    on<AuthEventShouldRegister>(((event, emit) =>
        emit(const AuthStateRegistering(exception: null, isLoading: false))));

    //forgot password
    on<AuthEventForgotPassword>(
      (event, emit) async {
        emit(const AuthStateForgetPassword(
            exception: null, hasSendEmail: false, isLoading: false));
        final email = event.email;
        if (email == null) {
          return;
        }
        emit(const AuthStateForgetPassword(
            exception: null, hasSendEmail: false, isLoading: true));
        bool didEmailSend;
        Exception? exception;
        try {
          await provider.sendPasswordReset(toEmail: email);
          didEmailSend = true;
          exception = null;
        } on Exception catch (e) {
          didEmailSend = false;
          exception = e;
        }
        emit( AuthStateForgetPassword(
          exception: exception, 
          hasSendEmail: didEmailSend, 
          isLoading: false));
      },
    );

    on<AuthEventLogIn>(((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: "Please wait while I log you in"));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedIn(user: user, isLoading: false));
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    }));
    on<AuthEventLogOut>(((event, emit) async {
      try {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    }));
  }
}
