import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'Com.dart';

class PostSelfCard extends StatefulWidget {
  final Post post;

  const PostSelfCard({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _PostSelfCardState createState() => _PostSelfCardState();
}

class _PostSelfCardState extends State<PostSelfCard> {
  String tempComment;
  String description='';
  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';

  void setImageUrl(String tempUrl){
    if(tempUrl != widget.post.image){
      this.imageUrl = tempUrl;
    }else{
      this.imageUrl = widget.post.image;
    }
  }
  void setTempImage(File tempUrl){
    setState(() {
      tempFile = tempUrl;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      //TODO change to user image
                      backgroundImage: NetworkImage(LoggedUser.image),
                      radius: 40,
                    ),
                    title: Text(widget.post.sender.name),
                    subtitle: Text(widget.post.sender.username),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        _editPost(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
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
                        widget.post.commentList.length != 0
                            ? _openPopup(context)
                            : _commentAdd(context);
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
                SizedBox(height: 20.0),

                IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await context
                        .read<PostService>()
                        .removePost(widget.post.id, LoggedUser.id);

                    Navigator.pushReplacementNamed(context, ModalRoute.of(context).settings.name);

                  },
                ),
              ],
            ),
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

  _editPost(context1) {
    Alert(
        context: context1,
        title: "Change Post",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onSaved: (String value) {
                  if (value != null){
                    description = value;
                  }
                },
              ),

            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              _formKey.currentState.save();

              await context.read<PostService>().editPost(widget.post.id, description);




              Navigator.pop(context1);
              Navigator.pushNamed(context1, ModalRoute.of(context).settings.name);
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  Future<void> selectAndPickImage() async{

    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      _image = File(pickedFile.path,);
      setTempImage(_image);
    } else {
      print('No image selected.');
    }

  }

  uploadToStorage(File image) async{
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference =   firebase_storage.FirebaseStorage.instance.ref().child(imageName);
    firebase_storage.UploadTask uploadTask = reference.putFile(image);
    firebase_storage.TaskSnapshot taskSnapshot =  await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then((url){
      setImageUrl(url);
    });

  }
}
