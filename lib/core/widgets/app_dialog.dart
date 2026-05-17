import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/app_button.dart';

Future<void> showAppDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'OK',
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        AppButton(
          onPressed: () => Navigator.of(context).pop(),
          label: confirmLabel,
          width: 120,
        ),
      ],
    ),
  );
}
