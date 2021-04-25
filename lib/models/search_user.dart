import 'package:cs310_app/objects/User.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/cupertino.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) => UserCard(
                  user: searchUser[index],

                )),
          ),
        ),




      ],
    );
  }
}
