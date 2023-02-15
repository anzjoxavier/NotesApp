import 'package:flutter/material.dart';
import 'package:simpleproject/constants/route.dart';
import 'package:simpleproject/services/auth/auth_exceptions.dart';
import 'package:simpleproject/services/auth/auth_service.dart';
import '../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: true,
            autocorrect: true,
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
                await AuthService.firebase()
                    .createUser(email: email, password: password);

                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(VerifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "Weak Password");
              } on InvalidEmailAuthException {
                await showErrorDialog(context, "Invalid Email");
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, "Email already in use");
              } on GenericAuthException {
              await showErrorDialog(context, "Authentication Error!");
              } 
            },
            child: const Text("Register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginRoute, (route) => false);
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}
