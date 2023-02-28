import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpleproject/services/cloud/cloud_note.dart';
import 'package:simpleproject/services/cloud/cloud_storage_constants.dart';
import 'package:simpleproject/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.where(ownerUserFieldName,isEqualTo: ownerUserId)
      .snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc)));

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote(
      {required String documentId, required String text}) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }


  Future<CloudNote> createNote({required String ownerUserId}) async {
    final document =
        await notes.add({ownerUserFieldName: ownerUserId, textFieldName: ''});
    final fetchedNote = await document.get();
    return CloudNote(
        documentId: fetchedNote.id, ownerUserId: ownerUserId, text: "");
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
