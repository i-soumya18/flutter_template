import 'package:flutter_template/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  UserEntity? getCurrentUser();
}
