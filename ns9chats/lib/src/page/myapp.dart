import 'package:go_router/go_router.dart';
import 'package:ns9chats/src/page/myappbar.dart';

import '../chat_window/chat_window.dart';
import '../navigator/router.dart';
import 'package:flutter/material.dart';


class Chat {
  const Chat({required this.name});

  final String name;
}

typedef Chats = void Function(Chat chats);

class ChatsList extends StatelessWidget {
  ChatsList({
    required this.chats,
    required this.onChat,
  }): super(key: ObjectKey(chats));

  final Chat chats;
  final Chats onChat;
  
  @override
  Widget build(BuildContext context) {
   return ListTile(
    onTap: () {
      context.push('/home/chat');
      onChat (chats);
    },
    leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(chats.name[0]
        ),
    ),
    title: Text(chats.name, style: _getTextStyle(context)),
   );
  }
}

TextStyle? _getTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
    );
  }

class ChatingList extends StatefulWidget {
  const ChatingList({required this.chats, super.key});

  final List<Chat> chats;

  @override
  State<ChatingList> createState() => _ChatingCard();
}
class _ChatingCard extends State<ChatingList> {
  void _handleChats(Chat chats) {
    setState(() {
    
    
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: widget.chats.map((chats) {
          return ChatsList(
            chats: chats,
            onChat: _handleChats,
          );
        }).toList(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const ChatingList(chats: [
        Chat(name: 'Дами'),
        Chat(name: 'Костя'),
        Chat(name: 'Миша'),
        Chat(name: 'Сергей'),
      ],),
    );
  }

  
}