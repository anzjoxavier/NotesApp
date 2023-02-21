// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:simpleproject/constants/route.dart';
import 'package:simpleproject/services/auth/auth_exceptions.dart';
import 'package:simpleproject/services/auth/auth_service.dart';
import 'package:simpleproject/services/auth/bloc/auth_bloc.dart';
import 'package:simpleproject/services/auth/bloc/auth_event.dart';

import '../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: true,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                context.read<AuthBloc>().add(AuthEventLogIn(email, password));
                
                // await AuthService.firebase()
                //     .logIn(email: email, password: password);
                // final user = AuthService.firebase().currentUser;
                // if (user?.isEmailVerified ?? false) {
                //   Navigator.of(context)
                //       .pushNamedAndRemoveUntil(NotesRoute, (route) => false);
                // } else {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //     VerifyEmailRoute,
                //     (route) => false,
                //   );
                // }
              } on UserNotfoundAuthException {
                await showErrorDialog(context, "User not found");
              } on WrongPasswordAuthException {
                await showErrorDialog(context, "Wrong password");
              } on GenericAuthException {
                await showErrorDialog(context, "Authentication Error!");
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RegisterRoute, (route) => false);
              },
              child: const Text("Register Here"))
        ],
      ),
    );
  }
}
