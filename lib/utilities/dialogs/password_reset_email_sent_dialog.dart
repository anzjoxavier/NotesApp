import 'package:flutter/material.dart';
import 'package:simpleproject/utilities/dialogs/generic_dialog.dart';

Future<void> passwordResetSendDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: "Password Reset",
      content: "We have send a password reset ",
      optionBulider: ()=>{
        "OK":null
      });
}
