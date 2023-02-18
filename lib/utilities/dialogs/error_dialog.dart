import 'package:flutter/material.dart';
import 'package:simpleproject/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text)  {
  return showGenericDialog(
      context: context,
      title: "An Error Occured",
      content: text,
      optionBulider: () => {"OK": null});
  
}
