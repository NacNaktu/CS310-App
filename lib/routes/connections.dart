import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/User.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Connections extends StatefulWidget {
  final User user;

  const Connections({Key key, this.user}) : super(key: key);
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {


  Future<void> loadUsers() async {
    context.read<FirestoreServicee>().getConnections(widget.user);
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
    //TODO GET ALL USER CONNECTIONS HERE



    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: AppColors.appBarColour,
        title: Text("Following"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
                itemCount: userConnections.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 4.6,
                ),
                itemBuilder: (context, index) => UserCard(
                  user: userConnections[index],

                )),
          ),




        ],
      ),
    );
  }
}
