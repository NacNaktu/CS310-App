import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';

class PostCard {
  int likes;
  String comments;
  DateInputElement date;

  PostCard({this.likes, this.comments, this.date});
}

class UserCard {
  String name, surname, username;
  int followers, following, posts;

  UserCard({this.name, this.surname, this.username, this.followers, this.following, this.posts});
}

class SearchResultCard {
  String word;

  SearchResultCard ({this.word});
}

class NotifCard {
  String message, follow, like;

  NotifCard({this.message, this.follow, this.like});
}