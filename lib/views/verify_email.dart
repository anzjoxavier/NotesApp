import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpleproject/constants/route.dart';
import 'package:simpleproject/services/auth/auth_service.dart';
import 'package:simpleproject/services/auth/bloc/auth_bloc.dart';
import 'package:simpleproject/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Column(
        children: [
          const Text("Verification Email has been send please verify it."),
          const Text(
              "If you haven't received email yet, press the button below."),
          TextButton(
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text("Verify Email")),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
