import 'package:flutter_template/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}
