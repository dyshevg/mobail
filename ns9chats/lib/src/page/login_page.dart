import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onLogin});
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Login'),
          const SizedBox(height: 12),
          FilledButton.icon(
            icon: const Icon(Icons.lock_open),
            label: const Text('Войти'),
            onPressed: onLogin,
          ),
        ]),
      ),
    );
  }
}