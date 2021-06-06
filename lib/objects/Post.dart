

import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




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
      color: AppColors.cardColor,

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(user: widget.post.sender)),
                );
              },
              child: Container(
                width:  MediaQuery. of(context). size. width,

                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text(widget.post.sender.name + " " + widget.post.sender.surname),
                      subtitle: Text(widget.post.sender.username),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex:1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      //Todo resim degistirilecek
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cs310-7f676.appspot.com/o/1622915138057?alt=media&token=be8a8923-15fb-4164-b47c-4a25f168d64c"),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.post.description,
                  style: postTextStyle ,
                ),
              ],
            ),

            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.thumb_up, color: widget.post.likedUsers.contains(LoggedUser.username) ? Colors.green: Colors.grey,),
                    onPressed: () async {
                      await context.read<PostService>().likePost(widget.post.id,LoggedUser.id);
                      setState((){
                        if(widget.post.likedUsers.contains(LoggedUser.username)) {
                          widget.post.likedUsers.remove(LoggedUser.username);

                        }else {

                          widget.post.likedUsers.add(LoggedUser.username);
                          if (widget.post.dislikedUsers.contains(LoggedUser.username) ){

                            widget.post.dislikedUsers.remove(LoggedUser.username);
                          }
                        }

                      });
                    },),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.likedUsers.length}",
                      style: TextStyle(color: widget.post.likedUsers.contains(LoggedUser.username) ? Colors.green: Colors.grey,),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        await context.read<PostService>().dislikePost(widget.post.id,LoggedUser.id);
                        setState((){
                          if(widget.post.dislikedUsers.contains(LoggedUser.username)) {

                            widget.post.dislikedUsers.remove(LoggedUser.username);



                          }else {

                            widget.post.dislikedUsers.add(LoggedUser.username);
                            if (widget.post.likedUsers.contains(LoggedUser.username) ){

                              widget.post.likedUsers.remove(LoggedUser.username);
                            }
                          }

                        });
                      },
                      icon: Icon(Icons.thumb_down, color: widget.post.dislikedUsers.contains(LoggedUser.username) ? Colors.red: Colors.grey,),),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.dislikedUsers.length}",
                      style: TextStyle(color: widget.post.dislikedUsers.contains(LoggedUser.username) ? Colors.red: Colors.grey,),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.comment, color: Colors.grey,)),
                    SizedBox(height: 8.0),
                    Text(
                      "${widget.post.commentList.length}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.bookmark, color: LoggedUser.bookmarked.contains(widget.post) ? Colors.yellowAccent : Colors.grey,),
                      onPressed: () async{
                        await context.read<PostService>().bookmarkPost(widget.post.id,LoggedUser.id);

                        setState((){
                          if(LoggedUser.bookmarked.contains(widget.post)) {

                            LoggedUser.bookmarked.remove(widget.post);
                          }else {

                            LoggedUser.bookmarked.add(widget.post);

                          }

                        });
                      },),
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
                    IconButton(icon: Icon(Icons.repeat, color: LoggedUser.shared.contains(widget.post)? Colors.blue:Colors.grey,),
                      onPressed: () async{
                        // await context.read<PostService>().resharePost(widget.post.id,LoggedUser.id);
                        setState((){
                          if(LoggedUser.shared.contains(widget.post)) {

                            LoggedUser.shared.remove(widget.post);
                          }else {

                            LoggedUser.shared.add(widget.post);

                          }

                        });
                      },),
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