import 'package:flutter_template/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_template/features/auth/data/models/user_model.dart';
import 'package:flutter_template/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Stream<UserEntity?> authStateChanges() {
    return _remoteDataSource.authStateChanges().map(
          (user) => user == null ? null : UserModel.fromFirebase(user),
        );
  }

  @override
  UserEntity? getCurrentUser() {
    final user = _remoteDataSource.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw StateError('Unable to sign in user');
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final credential = await _remoteDataSource.signInWithGoogle();
    final user = credential.user;
    if (user == null) throw StateError('Unable to sign in with Google');
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw StateError('Unable to create user');
    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();
}
