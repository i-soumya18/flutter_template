import 'package:flutter_template/features/profile/domain/entities/profile_entity.dart';

class ProfileRepositoryImpl {
  Future<ProfileEntity> getProfile() async {
    return const ProfileEntity(
      name: 'Rite User',
      email: 'user@ritelabs.com',
    );
  }
}
