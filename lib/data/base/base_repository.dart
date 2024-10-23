import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantist/core/result/result.dart';

mixin BaseRepository {
  Future<Result<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      T result = await apiCall();

      return Result.success(result);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error: ${e.message}');
      return Result.failure('Firebase Auth Error: ${e.message}');
    } on FirebaseException catch (e) {
      log('Firebase Error: ${e.message}');
      return Result.failure('Firebase Error: ${e.message}');
    } catch (e) {
      log('General Error: $e');
      return Result.failure('General Error: $e');
    }
  }
}
