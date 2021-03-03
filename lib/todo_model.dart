import 'package:flutter/cupertino.dart';

class TodoModel {
  String title;
  IconData icon;

  String get getTitle => title;
  IconData get getIcon => icon;

  TodoModel(this.title, this.icon);
}
