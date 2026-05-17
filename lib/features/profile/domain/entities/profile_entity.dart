import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String? avatarUrl;

  @override
  List<Object?> get props => [name, email, avatarUrl];
}
