import 'package:cs310_app/objects/User.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:provider/provider.dart';


class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {

  Future<void> loadUsers() async {
    await context.read<FirestoreServicee>().getAllUser();
    await Future.delayed(Duration(milliseconds: 220));
  }


  @override
  Widget build(BuildContext context) {
    loadUsers();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: GridView.builder(
              itemCount: searchUser.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 4.6,
              ),
              itemBuilder: (context, index) => UserCard(
                user: searchUser[index],

              )),
        ),




      ],
    );
  }
}
