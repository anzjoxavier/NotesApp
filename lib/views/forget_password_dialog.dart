import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpleproject/services/auth/auth_exceptions.dart';
import 'package:simpleproject/services/auth/bloc/auth_bloc.dart';
import 'package:simpleproject/services/auth/bloc/auth_event.dart';
import 'package:simpleproject/services/auth/bloc/auth_state.dart';
import 'package:simpleproject/utilities/dialogs/error_dialog.dart';

import '../utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgetPassword) {
          if (state.hasSendEmail) {
            _textEditingController.clear();
            await passwordResetSendDialog(context);
          } else if (state.exception != null) {
            if (state.exception is InvalidEmailAuthException) {
              await showErrorDialog(context, "Invalid Email");
            } else if (state.exception is UserNotfoundAuthException) {
              await showErrorDialog(context, "User Not Found");
            } else {
              await showErrorDialog(context,
                  "We can't not process your request.Please check your email is registered.");
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forget Password"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                  "We can't not process your request.Please check your email is registered."),
              TextField(
                keyboardType:TextInputType.emailAddress,
                autocorrect: false,
                controller: _textEditingController,
                decoration: const InputDecoration(hintText: "Your Email Address"),
              ),
              TextButton(
                  onPressed: () {
                    final email = _textEditingController.text;
                    context
                        .read<AuthBloc>()
                        .add( AuthEventForgotPassword(email: email),
                        );
                  },
                  child: const Text("Send me password reset link.")),
                  TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventLogOut(),
                        );
                  },
                  child: const Text("Back to login page.")),
                  
            ],
          ),
        ),
      ),
    );
  }
}
