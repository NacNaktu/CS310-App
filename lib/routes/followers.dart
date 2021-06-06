import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/User.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Followers extends StatefulWidget {
  final User user;

  const Followers({Key key, this.user}) : super(key: key);
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {


  Future<void> loadUsers() async {
    context.read<FirestoreServicee>().getFollowers(widget.user);
    await Future.delayed(Duration(milliseconds: 200));
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    loadUsers();


  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: AppColors.appBarColour,
        title: Text("Followers"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
                itemCount: userFollowers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 4.6,
                ),
                itemBuilder: (context, index) => UserCard(
                  user: userFollowers[index],

                )),
          ),




        ],
      ),
    );
  }
}
