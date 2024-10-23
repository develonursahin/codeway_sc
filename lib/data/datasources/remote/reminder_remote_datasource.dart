import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantist/data/models/reminder_model.dart';

abstract class ReminderRemoteDatasource {
  Future<List<ReminderModel>> getAll({
    required String userId,
  });

  Future<ReminderModel> getById({
    required String userId,
    required String reminderId,
  });

  Future<void> setReminderAsUndone({
    required String userId,
    required String reminderId,
  });

  Future<void> setReminderAsDone({
    required String userId,
    required String reminderId,
  });

  Future<String> create({
    required String userId,
    required ReminderModel model,
  });

  Future<void> update({
    required String userId,
    required ReminderModel model,
  });

  Future<void> delete({
    required String userId,
    required String reminderId,
  });
  Future<void> deleteByUserId({
    required String userId,
    required String collectionName,
  });
  Future<void> deleteSelectedReminders({
    required String userId,
    required List<String> reminderIds,
  });
  Future<String> uploadImage({
    required File file,
    required String uuid,
    required String userId,
  });
}

class ReminderRemoteDatasourceImpl extends ReminderRemoteDatasource {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection("users");
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> create({
    required String userId,
    required ReminderModel model,
  }) async {
    var id = _ref.doc(userId).collection('reminders').doc().id;
    model.id = id;
    await _ref.doc(userId).collection('reminders').doc(id).set(model.toMap());
    return id;
  }

  @override
  Future<void> delete({
    required String userId,
    required String reminderId,
  }) {
    return _ref.doc(userId).collection('reminders').doc(reminderId).delete();
  }

  @override
  Future<void> deleteByUserId({
    required String userId,
    required String collectionName,
  }) async {
    var collectionRef = _ref.doc(userId).collection(collectionName);

    var snapshots = await collectionRef.get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  @override
  Future<void> deleteSelectedReminders({
    required String userId,
    required List<String> reminderIds,
  }) async {
    var collectionRef = _ref.doc(userId).collection('reminders');

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var reminderId in reminderIds) {
      var docRef = collectionRef.doc(reminderId);

      batch.delete(docRef);
    }

    await batch.commit();
  }

  @override
  Future<List<ReminderModel>> getAll({
    required String userId,
  }) async {
    var documentSnapshot = await _ref.doc(userId).collection('reminders').get();
    var list = documentSnapshot.docs
        .map(
          (e) => ReminderModel.fromMap(e.data()),
        )
        .toList();
    return list;
  }

  @override
  Future<ReminderModel> getById({
    required String userId,
    required String reminderId,
  }) async {
    var documentSnapshot = await _ref.doc(userId).collection('reminders').doc(reminderId).get();
    return ReminderModel.fromMap(documentSnapshot.data()!);
  }

  @override
  Future<void> setReminderAsDone({
    required String userId,
    required String reminderId,
  }) async {
    final sfDocRef = _ref.doc(userId).collection('reminders').doc(reminderId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(sfDocRef, {"isDone": true});
    });
  }

  @override
  Future<void> setReminderAsUndone({
    required String userId,
    required String reminderId,
  }) async {
    final sfDocRef = _ref.doc(userId).collection('reminders').doc(reminderId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(sfDocRef, {"isDone": false});
    });
  }

  @override
  Future<void> update({
    required String userId,
    required ReminderModel model,
  }) {
    return _ref.doc(userId).collection('reminders').doc(model.id).update(model.toMap());
  }

  @override
  Future<String> uploadImage({
    required File file,
    required String uuid,
    required String userId,
  }) async {
    var taskSnapshot =
        await _storage.ref().child(userId).child("reminders").child(uuid).putFile(file);
    return await taskSnapshot.ref.getDownloadURL();
  }
}
