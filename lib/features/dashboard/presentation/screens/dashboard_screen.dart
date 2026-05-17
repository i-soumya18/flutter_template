import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/app_empty_view.dart';

enum DashboardTab { home, explore, activity }

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    required this.tab,
    super.key,
  });

  final DashboardTab tab;

  @override
  Widget build(BuildContext context) {
    return switch (tab) {
      DashboardTab.home => _HomeTab(),
      DashboardTab.explore => _ExploreTab(),
      DashboardTab.activity => _ActivityTab(),
    };
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Home', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        ...List.generate(
          4,
          (index) => Card(
            child: ListTile(
              title: Text('Content card ${index + 1}'),
              subtitle: const Text('Home placeholder module'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExploreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => Card(
        child: Center(child: Text('Explore ${index + 1}')),
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: 12,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.bolt_outlined),
        title: Text('Activity item ${index + 1}'),
        subtitle: const Text('Recent activity placeholder'),
      ),
    );
  }
}

class PlaceholderTab extends StatelessWidget {
  const PlaceholderTab({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => AppEmptyView(message: message);
}
