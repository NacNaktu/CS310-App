import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  String description;
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";


  void setImageUrl(String tempUrl){
    this.imageUrl = tempUrl;
  }

  void setTempImage(File tempUrl){
    setState(() {
      tempFile = tempUrl;
    });

  }



  Future<void> savePost() async {
    await uploadToStorage(tempFile);
    String post1Id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    DocumentReference post1 = FirebaseFirestore.instance.collection('post').doc(
        post1Id);
    post1.set({
      "userId": LoggedUser.id,
      "description": description,
      "imageUrl": imageUrl,
      "date": DateTime.now().toString(),
      "likedUsers": [],
      "commentList": []
    });
    DocumentReference postList = FirebaseFirestore.instance.collection('postList').doc(LoggedUser.id);
    postList.update({
      "postList": FieldValue.arrayUnion([post1Id])
    });
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    File tempFile;

  }


  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _openPopup(context);
        },
      ),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: AppColors.appBarColour,
        title: Text("Feed"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomBar(index:0),
      body:Column(
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
                itemCount: feedPost.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => PostCard(
                  post: feedPost[index],

                )),
          ),

        ],
      ),

    );
  }

  _openPopup(context1) {
    Alert(
        context: context1,
        title: "Add Post",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onSaved: (String value) {
                  description = value;
                },
              ),

              InkWell(
                onTap: (){
                  selectAndPickImage();


                },
                child: CircleAvatar(
                  backgroundImage: tempFile != null ? FileImage(tempFile) : NetworkImage(im),
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add_photo_alternate,
                    size: 60,
                    color: tempFile != null ? Colors.transparent : Colors.grey,
                  ),
                ),
              ),

            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              _formKey.currentState.save();
              // savePost();
              await context.read<PostService>().savePost(description,tempFile,LoggedUser.id);




              Navigator.pop(context1);
              Navigator.pushNamed(context1, "/feed");
            },
            child: Text(
              "Add",
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