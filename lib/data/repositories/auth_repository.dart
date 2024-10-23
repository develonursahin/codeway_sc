import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantist/core/result/result.dart';
import 'package:plantist/data/base/base_repository.dart';
import 'package:plantist/data/datasources/local/auth_local_datasource.dart';
import 'package:plantist/data/datasources/remote/auth_remote_datasource.dart';

abstract class AuthRepository {
  Future<Result<User>> signIn({
    required String email,
    required String password,
  });

  Future<Result<User>> signUp({
    required String email,
    required String password,
  });

  Future<Result> signOut();

  Result<User> getCurrentUser();

  Future<Result<bool>> localAuth();
}

class AuthRepositoryImpl extends AuthRepository with BaseRepository {
  final AuthRemoteDatasource _remoteDatasource = AuthRemoteDatasourceImpl();
  final AuthLocalDatasource _localDatasource = AuthLocalDatasourceImpl();

  @override
  Result<User> getCurrentUser() {
    var currentUser = _remoteDatasource.getCurrentUser();
    if (currentUser == null) {
      return Result.failure("Current user is not available");
    }
    return Result.success(currentUser);
  }

  @override
  Future<Result<User>> signIn({
    required String email,
    required String password,
  }) {
    return safeApiCall(
      () async {
        var user =
            await _remoteDatasource.signIn(email: email, password: password);
        return user!;
      },
    );
  }

  @override
  Future<Result> signOut() {
    return safeApiCall(() async {
      await _remoteDatasource.signOut();
    });
  }

  @override
  Future<Result<User>> signUp({
    required String email,
    required String password,
  }) {
    return safeApiCall(
      () async {
        var user =
            await _remoteDatasource.signUp(email: email, password: password);
        return user!;
      },
    );
  }

  @override
  Future<Result<bool>> localAuth() {
    return safeApiCall(
      () {
        return _localDatasource.localAuth();
      },
    );
  }
}
