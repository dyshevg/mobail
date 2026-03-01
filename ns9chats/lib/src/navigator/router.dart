import 'package:ns9chats/src/appstate/app_state.dart';
import 'package:ns9chats/src/page/myapp.dart';
import 'package:ns9chats/src/page/myappbar.dart';
import 'package:go_router/go_router.dart';
import 'package:ns9chats/src/page/login_page.dart';
import 'package:ns9chats/src/page/settings_page.dart';
import 'tabs_scaffold.dart';

GoRouter createRouter (AppState appState){
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: appState,
    redirect: (context, state){
      final loggingIn = state.matchedLocation == '/login';
      final needsAuth = state.matchedLocation.startsWith('/setings');

       if (!appState.loggedIn && needsAuth && !loggingIn) {
        return '/login?from=${Uri.encodeComponent(state.matchedLocation)}';
      }
      if (appState.loggedIn && loggingIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(
          onLogin: () {
            appState.login();
            final from = state.uri.queryParameters['from'];
            context.go(from ?? '/home');
          },
        ),
      ),
       ShellRoute(
        builder: (context, state, child) => TabsScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const MyApp(),
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) => const MyApp(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => SettingsPage(
              onLogout: appState.logout,
            ),
          ),
        ],
      ),
    ],

  );
}