

import 'package:flutter/material.dart';



class NotifCardFollow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(Icons.arrow_right_alt),
          Text('This person followed you')
        ],
      ),
    );
  }
}

class NotifCardMsg extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(Icons.arrow_right_alt),
          Text('This person messaged you')
      ],
     ),
    );
   }
  }

class NotifCardLike extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(Icons.arrow_right_alt),
          Text('This person liked your photo')
        ],
      ),
    );
  }
}

class NotifCardComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(Icons.arrow_right_alt),
          Text('This person commented on your photo')
        ],
      ),
    );
  }
}