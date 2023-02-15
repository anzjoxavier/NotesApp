import 'package:flutter/material.dart';
import 'package:simpleproject/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Log Out",
      content: "Are you sure to Log out?",
      optionBulider: ()=>{
        'Cancel':false,
        'Log Out':true,
      }).then((value) => value??false);
}
