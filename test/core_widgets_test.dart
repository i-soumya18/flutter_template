import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/widgets/app_button.dart';
import 'package:flutter_template/core/widgets/app_loading.dart';
import 'package:flutter_template/core/widgets/app_text_field.dart';

void main() {
  testWidgets('AppButton renders label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppButton(
            onPressed: null,
            label: 'Primary',
          ),
        ),
      ),
    );

    expect(find.text('Primary'), findsOneWidget);
  });

  testWidgets('AppTextField renders with label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppTextField(
            label: 'Email',
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('AppLoadingWidget spinner renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppLoadingWidget(mode: AppLoadingMode.spinner),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
