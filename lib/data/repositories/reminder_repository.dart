import 'dart:io';

import 'package:plantist/core/result/result.dart';
import 'package:plantist/data/base/base_repository.dart';
import 'package:plantist/data/datasources/remote/reminder_remote_datasource.dart';
import 'package:plantist/data/models/reminder_model.dart';

abstract class ReminderRepository {
  Future<Result<List<ReminderModel>>> getAll({
    required String userId,
  });

  Future<Result<ReminderModel>> getById({
    required String userId,
    required String reminderId,
  });

  Future<Result> setReminderAsUndone({
    required String userId,
    required String reminderId,
  });

  Future<Result> setReminderAsDone({
    required String userId,
    required String reminderId,
  });

  Future<Result<String>> create({
    required String userId,
    required ReminderModel model,
  });

  Future<Result> update({
    required String userId,
    required ReminderModel model,
  });

  Future<Result> delete({
    required String userId,
    required String reminderId,
  });
  Future<Result> deleteByUserId({
    required String userId,
    required String collectionName,
  });
  Future<void> deleteSelectedReminders({
    required String userId,
    required List<String> reminderIds,
  });
  Future<Result<String>> uploadImage({
    required File file,
    required String uuid,
    required String userId,
  });
}

class ReminderRepositoryImpl extends ReminderRepository with BaseRepository {
  final ReminderRemoteDatasource _remoteDatasource = ReminderRemoteDatasourceImpl();

  @override
  Future<Result<String>> create({
    required String userId,
    required ReminderModel model,
  }) async {
    return safeApiCall(() async {
      return await _remoteDatasource.create(
        userId: userId,
        model: model,
      );
    });
  }

  @override
  Future<Result> delete({
    required String userId,
    required String reminderId,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.delete(
        userId: userId,
        reminderId: reminderId,
      );
    });
  }

  @override
  Future<Result> deleteByUserId({
    required String userId,
    required String collectionName,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.deleteByUserId(
        userId: userId,
        collectionName: collectionName,
      );
    });
  }

  @override
  Future<Result> deleteSelectedReminders({
    required String userId,
    required List<String> reminderIds,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.deleteSelectedReminders(
        userId: userId,
        reminderIds: reminderIds,
      );
    });
  }

  @override
  Future<Result<List<ReminderModel>>> getAll({
    required String userId,
  }) {
    return safeApiCall(() async {
      return await _remoteDatasource.getAll(userId: userId);
    });
  }

  @override
  Future<Result<ReminderModel>> getById({
    required String userId,
    required String reminderId,
  }) {
    return safeApiCall(() async {
      return await _remoteDatasource.getById(
        userId: userId,
        reminderId: reminderId,
      );
    });
  }

  @override
  Future<Result> setReminderAsDone({
    required String userId,
    required String reminderId,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.setReminderAsDone(
        userId: userId,
        reminderId: reminderId,
      );
    });
  }

  @override
  Future<Result> setReminderAsUndone({
    required String userId,
    required String reminderId,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.setReminderAsUndone(
        userId: userId,
        reminderId: reminderId,
      );
    });
  }

  @override
  Future<Result> update({
    required String userId,
    required ReminderModel model,
  }) {
    return safeApiCall(() async {
      await _remoteDatasource.update(
        userId: userId,
        model: model,
      );
    });
  }

  @override
  Future<Result<String>> uploadImage({
    required File file,
    required String uuid,
    required String userId,
  }) {
    return safeApiCall(() async {
      return await _remoteDatasource.uploadImage(
        file: file,
        uuid: uuid,
        userId: userId,
      );
    });
  }
}
