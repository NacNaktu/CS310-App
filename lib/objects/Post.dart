

import 'package:cs310_app/utils/classes.dart';
import 'package:flutter/material.dart';


class PostCard extends StatelessWidget {

  final Post post;

  const PostCard({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(),
              title: Text( post.sender.name + post.sender.surname),
              subtitle: Text(post.sender.username),
            ),
            Expanded(
              flex:1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.image),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Text("berkinkaracam", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4.0,),
                    Text("This is Rize, Çamlıhemşin."),
                  ],
                ),
                SizedBox(height: 4.0,),
                Row(
                  children: <Widget>[
                    Text("yunusyasar", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4.0,),
                    Text("Nice"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.thumb_up, color: Colors.grey,)),
                    SizedBox(height: 8.0),
                    Text(
                      "${post.likes}",
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
                      "${post.dislike}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.comment, color: Colors.grey,)),
                    SizedBox(height: 8.0),
                    Text(
                      "${post.commentNum}",
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