import "package:flutter/material.dart";



class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? titleText;
  final Image? titleImage;
  final IconButton? titleButtun;
    MyAppBar({
      super.key,
      this.titleText,
      this.titleImage,
      this.titleButtun,
      });

    @override
    Widget build(BuildContext context){
      return AppBar(
              title: Row(
                children: [
                  titleButtun??
                  titleImage??
                  const SizedBox(width: 10),
                    Text(
                    titleText?? "NS9 Chats",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                ],
              ),
              centerTitle: false,
            ); 
    }
@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
