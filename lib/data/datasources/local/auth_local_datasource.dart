import 'package:local_auth/local_auth.dart';
import 'package:plantist/core/constants/app_text.dart';

abstract class AuthLocalDatasource {
  Future<bool> localAuth();
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  @override
  Future<bool> localAuth() async {
    final localAuth = LocalAuthentication();
    var result = await localAuth.authenticate(
      localizedReason: AppText.confirmAuth,
      options: const AuthenticationOptions(stickyAuth: true),
    );
    return result;
  }
}
