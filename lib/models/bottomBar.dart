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
    return TabBar(
      controller: DefaultTabController,
      tabs: <Widget>[
        Tab(child: IconButton(
          icon: Icon(Icons.home, color: Colors.white,),

        ),
        ),
        Tab(child: Icon(Icons.search, color: Colors.white,)),
        Tab(child: Icon(Icons.person, color: Colors.white,)),
        Tab(child: Icon(Icons.add_circle_outline, color: Colors.white,)),
      ],
    );
  }
}