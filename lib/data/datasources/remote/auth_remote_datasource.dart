import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {
  Future<User?> signIn({
    required String email,
    required String password,
  });

  Future<User?> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  User? getCurrentUser();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
