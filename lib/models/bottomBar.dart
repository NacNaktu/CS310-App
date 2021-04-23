import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int index = 0;

  var routes = {
    0 : '/welcome',
    1 : '/search',
    2 : '/profile',
  };

  void onTap (int index)  {
    Navigator.pushNamed(context, routes[index]);
  }

  // By default our first item will be selected


  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'More',
            ),
          ],
          iconSize: 20,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: (index) => onTap(index),
            currentIndex: index,
            selectedItemColor: Colors.blue,

    ),
        ),
      );
  }
}