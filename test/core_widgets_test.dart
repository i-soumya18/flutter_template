import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/widgets/app_bottom_sheet.dart';
import 'package:flutter_template/core/widgets/app_button.dart';
import 'package:flutter_template/core/widgets/app_dialog.dart';
import 'package:flutter_template/core/widgets/app_empty_view.dart';
import 'package:flutter_template/core/widgets/app_error_view.dart';
import 'package:flutter_template/core/widgets/app_image.dart';
import 'package:flutter_template/core/widgets/app_loading.dart';
import 'package:flutter_template/core/widgets/app_snackbar.dart';
import 'package:flutter_template/core/widgets/app_text_field.dart';
import 'package:flutter_template/core/widgets/async_value_widget.dart';
import 'package:flutter_template/features/dashboard/presentation/widgets/dashboard_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget app(Widget child) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(body: child),
    );
  }

  testWidgets('AppButton renders all variants and loading state',
      (tester) async {
    await tester.pumpWidget(
      app(
        Column(
          children: AppButtonVariant.values
              .map(
                (variant) => AppButton(
                  onPressed: () {},
                  label: variant.name,
                  variant: variant,
                ),
              )
              .toList()
            ..add(
              const AppButton(
                onPressed: null,
                label: 'Loading',
                loading: true,
              ),
            ),
        ),
      ),
    );

    for (final variant in AppButtonVariant.values) {
      expect(find.text(variant.name), findsOneWidget);
    }
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppTextField renders variants and toggles password visibility',
      (tester) async {
    await tester.pumpWidget(
      app(
        const Column(
          children: [
            AppTextField(
              label: 'Email',
            ),
            AppTextField(
              label: 'Search',
              variant: AppTextFieldVariant.search,
            ),
            AppTextField(
              label: 'Password',
              variant: AppTextFieldVariant.password,
            ),
          ],
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsOneWidget);

    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

  testWidgets('AppLoadingWidget renders spinner and shimmer modes',
      (tester) async {
    await tester.pumpWidget(
      app(
        const Column(
          children: [
            AppLoadingWidget(mode: AppLoadingMode.spinner),
            AppLoadingWidget(mode: AppLoadingMode.shimmer),
          ],
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(AppLoadingWidget), findsNWidgets(2));
  });

  testWidgets('Error, empty, image, and async widgets render', (tester) async {
    await tester.pumpWidget(
      app(
        AsyncValueWidget<String>(
          value: const AsyncData('Ready'),
          data: (value) => Column(
            children: [
              Text(value),
              const AppErrorView(message: 'Something went wrong'),
              const AppEmptyView(message: 'Nothing here'),
              const AppImage(url: 'https://example.invalid/image.png'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Ready'), findsOneWidget);
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Nothing here'), findsOneWidget);
    expect(find.byType(AppImage), findsOneWidget);
  });

  testWidgets('Dialog helper renders', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showAppDialog(
                context,
                title: 'Confirm',
                message: 'Dialog message',
              ),
              child: const Text('Open dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Dialog message'), findsOneWidget);
  });

  testWidgets('Snackbar helper renders', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => AppSnackbar.show(context, 'Snack message'),
              child: const Text('Open snackbar'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open snackbar'));
    await tester.pump();
    expect(find.text('Snack message'), findsOneWidget);
  });

  testWidgets('Bottom sheet helper renders', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showAppBottomSheet<void>(
                context,
                builder: (_) => const Text('Sheet content'),
              ),
              child: const Text('Open sheet'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();
    expect(find.text('Sheet content'), findsOneWidget);
  });

  testWidgets('Dashboard shell exposes five tappable nav tabs', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => DashboardScaffold(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const Text('Home tab'),
            ),
            GoRoute(
              path: '/explore',
              builder: (_, __) => const Text('Explore tab'),
            ),
            GoRoute(
              path: '/activity',
              builder: (_, __) => const Text('Activity tab'),
            ),
            GoRoute(
              path: '/profile',
              builder: (_, __) => const Text('Profile tab'),
            ),
            GoRoute(
              path: '/settings',
              builder: (_, __) => const Text('Settings tab'),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: true),
          routerConfig: router,
        ),
      ),
    );

    for (final label in [
      'Home',
      'Explore',
      'Activity',
      'Profile',
      'Settings',
    ]) {
      expect(find.text(label), findsOneWidget);
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(find.text('$label tab'), findsOneWidget);
    }
  });
}
