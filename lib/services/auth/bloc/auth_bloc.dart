import 'package:bloc/bloc.dart';
import 'package:simpleproject/services/auth/auth_provider.dart';
import 'package:simpleproject/services/auth/bloc/auth_event.dart';
import 'package:simpleproject/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUnintialized()) {
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
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    }));
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(email: email, password: password);
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(e));
        }
      },
    );
    on<AuthEventShouldRegister>(((event, emit) => emit(const AuthStateRegistering(null))));
    
    on<AuthEventLogIn>(((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedIn(user));
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(const AuthStateNeedsVerification());
        } else {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          emit(AuthStateLoggedIn(user));
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
