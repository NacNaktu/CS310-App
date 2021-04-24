import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/User.dart';
import 'package:cs310_app/utils/categories.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  search = text;
                });
              },
              decoration: InputDecoration(
                icon: IconButton(
                  splashRadius: 24,
                  iconSize: 24,
                  icon: Icon(Icons.search),
                ),

              ),
            ),
          ),

        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Categories(),
            ],

          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: GridView.builder(
                  itemCount: searchUser.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => UserCard(
                    user: searchUser[index],

                  )),
            ),
          ),




        ],
      ),
    );
  }
}

