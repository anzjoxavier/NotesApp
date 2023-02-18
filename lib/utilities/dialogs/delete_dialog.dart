import 'package:flutter/material.dart';
import 'package:simpleproject/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Delete",
      content: "Are you sure to Delete?",
      optionBulider: ()=>{
        'Cancel':false,
        'Delete':true,
      }).then((value) => value??false);
      

}
