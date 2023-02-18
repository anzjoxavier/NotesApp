import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpleproject/services/cloud/cloud_storage_constants.dart';

class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;

  CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text
    });

    CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot):
    documentId=snapshot.id,
    ownerUserId=snapshot.data()[ownerUserFieldName] as String,
    text=snapshot.data()[textFieldName] as String;
}

