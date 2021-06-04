import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Feed extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  _openPopup(context) {
    Alert(
        context: context,
        title: "Add Product",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (String value) {
                  //name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                onSaved: (String value) {
                  //price = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Image',
                ),
                onSaved: (String value) {
                  //image = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                onSaved: (String value) {
                  //category = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Brand',
                ),
                onSaved: (String value) {
                  //brand = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onSaved: (String value) {
                  //description= value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Warranty',
                ),
                onSaved: (String value) {
                  //warranty = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Distributor',
                ),
                onSaved: (String value) {
                  //dis = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Stock',
                ),
                onSaved: (String value) {
                  //stock = value;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              _formKey.currentState.save();


              Navigator.pop(context);
              Navigator.pushNamed(context, "/pmm");
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}