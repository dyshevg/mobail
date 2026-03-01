
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';


class MyChat extends StatelessWidget{
  const MyChat({super.key});

    @override
    Widget build(BuildContext context){
      return MaterialApp(
         home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                  onPressed: () {Navigator.pop(context);}, 
                  icon: const Icon( Icons.arrow_back_outlined, ),
                  ),
                const Text(
                  "Чат №2",
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.amber,
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

