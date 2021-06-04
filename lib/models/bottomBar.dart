import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState(index);

  final int index;  // <--- generates the error, "Field doesn't override an inherited getter or setter"
  BottomBar({
    int index
  }): this.index = index;

}

class _BottomBarState extends State<BottomBar> {


  _BottomBarState(this.index);
  final int index;



  var routes = {
    0 : '/feed',
    1 : '/search',
    2 : '/profile',
    3 : '/notification'
  };

  void onTap (int index)  {
    Navigator.pop(context);
    Navigator.pushNamed(context, routes[index]);
  }

  // By default our first item will be selected


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
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
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),

      ],
      iconSize: 20,
      backgroundColor: AppColors.background,

      showUnselectedLabels: true,
      onTap: (index) => onTap(index),
        currentIndex: index,


    );
  }
}