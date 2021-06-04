

import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return  Card(

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(),
              title: Text( widget.post.sender.name + widget.post.sender.surname),
              subtitle: Text(widget.post.sender.username),
            ),
            Expanded(
              flex:1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.post.image),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.thumb_up, color: Colors.green,),
                    onPressed: (){
                      //Todo change likes in database
                      setState((){
                        if(widget.post.likedUsers.contains(LoggedUser.username)) {
                          widget.post.likes --;
                        }else {
                          widget.post.likes ++;
                        };

                      });
                    },),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.likes}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.thumb_down, color: Colors.grey,),),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.dislike}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.comment, color: Colors.grey,)),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.commentNum}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.bookmark, color: Colors.grey,)),
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
                    IconButton(icon: Icon(Icons.send, color: Colors.grey,)),
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
            SizedBox(height:20.0),
          ],
        ),
      ),
    );
  }
}