import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ns9chats/src/page/myappbar.dart';


class TabsScaffold extends StatelessWidget {
  const TabsScaffold({super.key, required this.child});
  final Widget child;

  int _locationToIndex(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0; // home (по умолчанию)
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      appBar: MyAppBar(),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/search');
            case 2:
              context.go('/settings');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined,color: Colors.amber,), selectedIcon: Icon(Icons.home, color: Colors.amber), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline, color: Colors.amber), selectedIcon: Icon(Icons.people, color: Colors.amber), label: 'Contacts'),
          NavigationDestination(icon: Icon(Icons.settings_outlined, color: Colors.amber), selectedIcon: Icon(Icons.settings, color: Colors.amber), label: 'Settings'),
        ],
      ),
    );
  }
}