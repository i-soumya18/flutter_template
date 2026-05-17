import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.name,
    required this.email,
    super.key,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 42,
              child: Icon(Icons.person, size: 42),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(name, style: Theme.of(context).textTheme.titleLarge),
        Text(email, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
