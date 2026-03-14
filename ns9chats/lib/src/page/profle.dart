import 'package:go_router/go_router.dart';
import 'package:ns9chats/src/page/myappbar.dart';

import '../chat_window/chat_window.dart';
import '../navigator/router.dart';
import 'package:flutter/material.dart';


class MyProfile extends StatelessWidget {
  const MyProfile ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSeed(
            seedColor: Colors.white70,
            brightness: Brightness.light
          ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme
          .fromSeed(
            seedColor: Colors.grey.shade600,
            brightness: Brightness.dark
          ),
      ),
      themeMode: ThemeMode.system,
      
      home: Scaffold(
        body:Expanded(
          child: Column(
                children: [
                  Card(
                    child: Container( 
                      height: 150,
                      width: 300,
                      child: const Column(
                        children: [
                          
                        ],
                      )
                      ),
                  )
                ],
                
              ),
        ),
        ),
    );
  }

  
}