import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["ALL", "USERS", "TOPICS", "LOCATIONS"];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.appBarColour,
      child: Padding(
        padding: const EdgeInsets.only( left:4.0, top:16.0, right:4.0, bottom:1.0),
        child: Container(

          width: MediaQuery. of(context). size. width - 16,
          height: 26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(index),
          ),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          search_category = categories[index];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? AppColors.primary : Colors.grey,
              ),
            ),


          ],


        ),
      ),
    );
  }
}
