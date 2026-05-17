import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:flutter_template/features/settings/presentation/widgets/settings_section.dart';
import 'package:flutter_template/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter_template/features/settings/presentation/widgets/theme_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _version = ValueNotifier<String>('-');
  final _pushEnabled = ValueNotifier<bool>(true);
  final _reminderEnabled = ValueNotifier<bool>(true);
  final _marketingEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  @override
  void dispose() {
    _version.dispose();
    _pushEnabled.dispose();
    _reminderEnabled.dispose();
    _marketingEnabled.dispose();
    super.dispose();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    _version.value = '${info.version}+${info.buildNumber}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        const SettingsSection(
          title: 'Appearance',
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: ThemePicker(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SettingsSection(
          title: 'Notifications',
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _pushEnabled,
              builder: (_, value, __) => SwitchListTile(
                title: const Text('Push'),
                value: value,
                onChanged: (next) => _pushEnabled.value = next,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _reminderEnabled,
              builder: (_, value, __) => SwitchListTile(
                title: const Text('Reminders'),
                value: value,
                onChanged: (next) => _reminderEnabled.value = next,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _marketingEnabled,
              builder: (_, value, __) => SwitchListTile(
                title: const Text('Marketing'),
                value: value,
                onChanged: (next) => _marketingEnabled.value = next,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SettingsSection(
          title: 'Account',
          children: [
            SettingsTile(
              title: 'Change email',
              onTap: () => context.go(RouteConstants.settingsAccount),
            ),
            const Divider(height: 1),
            SettingsTile(
              title: 'Change password',
              onTap: () => context.go(RouteConstants.settingsAccount),
            ),
            const Divider(height: 1),
            const SettingsTile(
              title: 'Delete account',
              subtitle: 'This action is permanent',
            ),
          ],
        ),
        const SizedBox(height: 20),
        SettingsSection(
          title: 'About',
          children: [
            ValueListenableBuilder<String>(
              valueListenable: _version,
              builder: (_, value, __) =>
                  SettingsTile(title: 'Version', subtitle: value, trailing: const SizedBox()),
            ),
            const Divider(height: 1),
            SettingsTile(
              title: 'Privacy policy',
              onTap: () => context.go(RouteConstants.settingsAbout),
            ),
            const Divider(height: 1),
            SettingsTile(
              title: 'Terms',
              onTap: () => context.go(RouteConstants.settingsAbout),
            ),
            const Divider(height: 1),
            const SettingsTile(title: 'Rate app'),
            const Divider(height: 1),
            const SettingsTile(title: 'Share app'),
          ],
        ),
      ],
    );
  }
}
