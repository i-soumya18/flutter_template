import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_constants.dart';
import 'package:go_router/go_router.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({required this.child, super.key});

  final Widget child;

  static const _destinations = [
    (
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      route: RouteConstants.dashboard,
    ),
    (
      label: 'Explore',
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
      route: RouteConstants.explore,
    ),
    (
      label: 'Activity',
      icon: Icons.timeline_outlined,
      selectedIcon: Icons.timeline,
      route: RouteConstants.activity,
    ),
    (
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      route: RouteConstants.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final matchedIndex = _destinations.indexWhere((d) => location == d.route);
    final currentIndex = matchedIndex < 0 ? 0 : matchedIndex;
    final showFab = currentIndex == 0;

    return Scaffold(
      body: child,
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_destinations[index].route),
        destinations: _destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
