
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile(user: widget.user)),
        );
      },
      child: Card(
        color: AppColors.cardColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(im),
                  radius: 50,
                ),
                title: Text(widget.user.name),
                subtitle: Text(widget.user.username),
                trailing:IconButton(
                  icon: LoggedUser.connections.contains(widget.user.id) ? Icon(Icons.remove_circle_outline) : Icon(Icons.add_circle_outline),
                  onPressed: () async {
                    //TODO CHANGE IN DATABASE
                    if(LoggedUser.connections.contains(widget.user.id)){
                      await context.read<FirestoreServicee>().removeConnection(widget.user.id, LoggedUser.id);

                      setState(() {
                        LoggedUser.connections.remove(widget.user.id);
                      });
                    }else{
                      if(widget.user.private){
                        //TODO Send Notification
                      }else{
                        await context.read<FirestoreServicee>().addConnection(widget.user.id, LoggedUser.id);
                        setState(() {
                          LoggedUser.connections.add(widget.user.id);
                        });
                      }

                    }
                  },
                ) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
