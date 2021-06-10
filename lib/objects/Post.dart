import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/routes/profilePerson.dart';
import 'package:cs310_app/routes/profilePrivate.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Com.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String tempComment;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if(widget.post.sender.private){
                  if(LoggedUser.connections.contains(widget.post.sender.id)){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonProfile(user: widget.post.sender)),
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivateProfile(user: widget.post.sender)),
                    );
                  }
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonProfile(user: widget.post.sender)),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        //TODO change to user image
                        backgroundImage: NetworkImage(widget.post.sender.image),
                        radius: 40,
                      ),
                      title: Text(widget.post.sender.name),
                      subtitle: Text(widget.post.sender.username),
                      trailing: IconButton(
                        icon: Icon(Icons.report),
                        onPressed: () async {
                          //TODO CHANGE IN DATABASE
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  //Todo resim degistirilecek
                  image: NetworkImage(widget.post.image),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.post.description,
                  style: postTextStyle,
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color:
                            widget.post.likedUsers.contains(LoggedUser.username)
                                ? Colors.green
                                : Colors.grey,
                      ),
                      onPressed: () async {
                        await context
                            .read<PostService>()
                            .likePost(widget.post.id, LoggedUser.id);
                        setState(() {
                          if (widget.post.likedUsers
                              .contains(LoggedUser.username)) {
                            widget.post.likedUsers.remove(LoggedUser.username);
                          } else {
                            widget.post.likedUsers.add(LoggedUser.username);
                            if (widget.post.dislikedUsers
                                .contains(LoggedUser.username)) {
                              widget.post.dislikedUsers
                                  .remove(LoggedUser.username);
                            }
                          }
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.likedUsers.length}",
                      style: TextStyle(
                        color:
                            widget.post.likedUsers.contains(LoggedUser.username)
                                ? Colors.green
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        await context
                            .read<PostService>()
                            .dislikePost(widget.post.id, LoggedUser.id);
                        setState(() {
                          if (widget.post.dislikedUsers
                              .contains(LoggedUser.username)) {
                            widget.post.dislikedUsers
                                .remove(LoggedUser.username);
                          } else {
                            widget.post.dislikedUsers.add(LoggedUser.username);
                            if (widget.post.likedUsers
                                .contains(LoggedUser.username)) {
                              widget.post.likedUsers
                                  .remove(LoggedUser.username);
                            }
                          }
                        });
                      },
                      icon: Icon(
                        Icons.thumb_down,
                        color: widget.post.dislikedUsers
                                .contains(LoggedUser.username)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.dislikedUsers.length}",
                      style: TextStyle(
                        color: widget.post.dislikedUsers
                                .contains(LoggedUser.username)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: widget.post.commentList.contains(LoggedUser.id)
                            ? Colors.green
                            : Colors.grey,
                      ),
                      onPressed: () {
                        //TODO
                        widget.post.commentList.length != 0 ?_openPopup(context):_commentAdd(context);
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.commentList.length}",
                      style: TextStyle(
                        color: widget.post.commentList.contains(LoggedUser.id)
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        color: LoggedUser.bookmarked.contains(widget.post)
                            ? Colors.yellowAccent
                            : Colors.grey,
                      ),
                      onPressed: () async {
                        await context
                            .read<PostService>()
                            .bookmarkPost(widget.post.id, LoggedUser.id);

                        setState(() {
                          if (LoggedUser.bookmarked.contains(widget.post)) {
                            LoggedUser.bookmarked.remove(widget.post);
                          } else {
                            LoggedUser.bookmarked.add(widget.post);
                          }
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    /*
                    Text(
                      "Bookmark",
                      style: TextStyle(color: Colors.grey),
                    ),
                    */
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.repeat,
                        color: LoggedUser.shared.contains(widget.post)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      onPressed: () async {
                        // await context.read<PostService>().resharePost(widget.post.id,LoggedUser.id);
                        setState(() {
                          if (LoggedUser.shared.contains(widget.post)) {
                            LoggedUser.shared.remove(widget.post);
                          } else {
                            LoggedUser.shared.add(widget.post);
                          }
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    /*
                    Text(
                      "Share",
                      style: TextStyle(color: Colors.grey),
                    ),
                    */
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Comments",
        content: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.width + 20,
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GridView.builder(
                      itemCount: widget.post.comments.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (context, index) => ComCard(
                            comment: widget.post.comments[index],
                          )),
                ],
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              _commentAdd(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.width,
              child: Text(
                "Send Comment",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ]).show();
  }

  _commentAdd(context) {
    Alert(
        context: context,
        title: "Send Comment",
        content: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String value) {
                tempComment = value;
              },
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              //Todo add comment
              await Future.delayed(Duration(milliseconds: 110));

              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/feed");
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}
