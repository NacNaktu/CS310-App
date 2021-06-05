
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:rflutter_alert/rflutter_alert.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = "";
  File image;
  FirestoreServicee _service;

  void setImageUrl(String tempUrl){
    this.imageUrl = tempUrl;
  }


  Future<void> loadPosts() async {
    await context.read<PostService>().getAllUserPostsId(LoggedUser.id);
    await Future.delayed(Duration(milliseconds: 100000));
  }


  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState()  {
    loadPosts();
  }



  @override
  Widget build(BuildContext context)  {
    loadPosts();



    double add;
    print(LoggedUser.id);

    add = widget.user.info != null ? 50 : 0;
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),
      backgroundColor: AppColors.background,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backwardsCompatibility: false,
            brightness: Brightness.dark,
            elevation: 0.0,
            backgroundColor: AppColors.appBarColour,

            floating: true,
            collapsedHeight: 208 + add,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
              centerTitle: false,

              title: Container(
                width: MediaQuery.of(context).size.width - 16,

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            GestureDetector(
                              onTap: () {_openPopup(context);},
                              child: CircleAvatar(backgroundImage: NetworkImage(LoggedUser.image),
                                radius: 50,),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.user.name + " " + widget.user.surname,
                                  style: underlinedStyle,
                                ),
                                Text(
                                  widget.user.username,
                                  style: underlinedStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.settings,
                            size: 20.0,

                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/psettings",
                            );
                          },
                        ),


                      ],
                    ),

                    Container(
                      height: widget.user.info != null? 50:0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.user.info != null ? widget.user.info : "",
                          style: bioTextStyle,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlinedButton(
                                    style: profilePageButtonStyle,
                                    onPressed: () {
                                      //TODO connect this to Topics
                                    },
                                    child: Text("Topics")),
                              )),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlinedButton(
                                    style: profilePageButtonStyle,
                                    onPressed: () {
                                      //TODO connect this to connections
                                    },
                                    child: Text("Connections")),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 500,
                  child: PostCard(
                    post: widget.user.shared[index],
                  ),
                );
              },
              childCount: widget.user.shared.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<File> selectAndPickImage() async{

    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      _image = File(pickedFile.path,);
    } else {
      print('No image selected.');
    }
    return _image;
  }

  uploadToStorage(File image) async{
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference =   firebase_storage.FirebaseStorage.instance.ref().child(imageName);
    firebase_storage.UploadTask uploadTask = reference.putFile(image);
    firebase_storage.TaskSnapshot taskSnapshot =  await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then((url){
      setImageUrl(url);
      LoggedUser.image = url;
      context.read<FirestoreServicee>().changePicture(LoggedUser.id,url);
    });




    
    //Todo resim ekleme eklenicek
  }


  _openPopup(context) {
    Alert(
        context: context,
        title: "Change Picture",
        content: Column(
          children: <Widget>[
            InkWell(

              child: Image.network(im)
            ),

          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              image = await selectAndPickImage();
              uploadToStorage(image);



              Navigator.pop(context);
              Navigator.pushNamed(context, "/profile");
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}
