import 'package:flutter/material.dart';
import 'package:simpleproject/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Sharing",
      content: "Can't Share an empty note",
      optionBulider:()=> {
        "Ok":null
      });
}
