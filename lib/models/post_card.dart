import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.all(16.0),
          height: 450.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(),
                title: Text("Berkin Karacam"),
                subtitle: Text("@berkinkaracam"),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://staticb.yolcu360.com/blog/wp-content/uploads/2019/02/15100941/camlihemsin-2.jpg"),
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
                        "30",
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
                        "10",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.comment, color: Colors.grey,)),
                      SizedBox(height: 8.0),
                      Text(
                        "3",
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
      ),
    );
  }
}
