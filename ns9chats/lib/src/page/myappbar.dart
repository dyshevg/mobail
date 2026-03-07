import "package:flutter/material.dart";



class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? titleText;
  final Image? titleImage;
    MyAppBar({
      super.key,
      this.titleText,
      this.titleImage,
      });

    @override
    Widget build(BuildContext context){
      return AppBar(
              title: Row(
                children: [
                  titleImage??
                  const SizedBox(width: 10),
                    Text(
                    titleText?? "NS9 Chats",
                    style: TextStyle(fontSize: 34, color: Colors.amber),
                  ),
                ],
              ),
              centerTitle: false,
            ); 
    }
@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
