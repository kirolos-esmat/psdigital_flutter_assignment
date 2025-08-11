import 'package:flutter/material.dart';

/// Shows a dismissible MaterialBanner at the top of the screen.
void showTopBanner(
  BuildContext context,
  String message, {
  Color color = Colors.orange,
  Duration duration = const Duration(seconds: 2),
  String closeLabel = 'CLOSE',
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentMaterialBanner();
  final banner = MaterialBanner(
    backgroundColor: color,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    actions: [
      TextButton(
        onPressed: () => messenger.hideCurrentMaterialBanner(),
        child: Text(closeLabel, style: const TextStyle(color: Colors.white)),
      ),
    ],
  );
  messenger.showMaterialBanner(banner);
  if (duration != Duration.zero) {
    Future.delayed(duration, () {
      if (messenger.mounted) messenger.hideCurrentMaterialBanner();
    });
  }
}
