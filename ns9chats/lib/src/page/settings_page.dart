import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.onLogout});
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Settings (требует авторизации)'),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            onLogout();
            context.go('/home');
          },
          child: const Text('Выйти'),
        ),
      ]),
    );
  }
}