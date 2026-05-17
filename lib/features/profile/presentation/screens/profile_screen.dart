import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/features/profile/presentation/widgets/profile_header.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const ProfileHeader(
          name: 'Rite User',
          email: 'user@ritelabs.com',
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: _StatCard(label: 'Projects', value: '24')),
            SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'Streak', value: '17d')),
            SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'Score', value: '92')),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.manage_accounts_outlined),
                title: const Text('Account'),
                onTap: () => context.go(RouteConstants.settingsAccount),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.tune_outlined),
                title: const Text('Preferences'),
                onTap: () => context.go(RouteConstants.settingsAppearance),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.support_agent_outlined),
                title: const Text('Support'),
                onTap: () => context.go(RouteConstants.settingsAbout),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
