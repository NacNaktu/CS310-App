import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> categories = ["Computer", "Telephone", "Television", "Vaccum"];

  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white,),

        ),
        IconButton(icon: Icon(Icons.search, color: Colors.white,),),
        IconButton(icon: Icon(Icons.person, color: Colors.white,),),
      ],
    );
  }
}