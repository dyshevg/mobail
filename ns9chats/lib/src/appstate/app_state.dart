import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool loggedIn = false;

  void login() {
    loggedIn = true;
    notifyListeners();
  }
  
  void logout() {
    loggedIn = false;
    notifyListeners();
  }
}