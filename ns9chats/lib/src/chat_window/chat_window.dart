
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ns9chats/src/navigator/router.dart';
import 'package:ns9chats/src/page/myappbar.dart';
// import 'package:flutter/scheduler.dart';


class MyChat extends StatelessWidget{
  const MyChat({super.key});

    @override
    Widget build(BuildContext context){
      return MaterialApp(
          debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme
          .fromSeed(
            seedColor: Colors.grey.shade200,
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
          appBar: MyAppBar(
            titleText: "Чат",
            titleButtun: IconButton(
              onPressed: () {
               context.pop();
            }, 
            icon: const Icon(
              Icons.arrow_back
              )),
          ),
           body: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  icon: const Icon(Icons.attach_file),
                  hintText: "Отправить сообщение :)",
                  fillColor: const Color.fromARGB(255, 193, 190, 190),
                  filled: true,
                ),
                onSubmitted: (text) {
                  print("Введенный текст: $text");
            },
                ),
            ),
           )
         )
        );  
    }
}

