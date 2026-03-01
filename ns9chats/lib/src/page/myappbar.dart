import "package:flutter/material.dart";



class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
   const MyAppBar({super.key});

    @override
    Widget build(BuildContext context){
      return AppBar(
              title: Row(
                children: [
                  Image.asset("android/assets/images/ic_launcher.png", width: 50, height: 50,),
                  const SizedBox(width: 10),
                  const Text(
                    "NS9 Chats",
                    style: TextStyle(fontSize: 34, color: Colors.white),
                  ),
                ],
              ),
              backgroundColor: Colors.blueGrey,
              centerTitle: false,
            ); 
    }
@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
