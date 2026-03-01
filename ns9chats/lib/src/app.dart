import 'package:flutter/material.dart';

import 'navigator/router.dart';
import 'appstate/app_state.dart';


class App extends StatefulWidget {
  const App({ super.key });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appState = AppState();
  
  
  @override
  Widget build(BuildContext context) {
    final router = createRouter(appState);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSeed(
            seedColor: Colors.blueGrey,
            brightness: Brightness.light
          ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme
          .fromSeed(
            seedColor: Colors.blueGrey,
            brightness: Brightness.dark
          ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}