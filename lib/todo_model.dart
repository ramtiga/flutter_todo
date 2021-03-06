import 'package:flutter/cupertino.dart';

class TodoModel {
  String _title;
  IconData _icon;
  DateTime _dateTime;

  String get getTitle => _title;
  IconData get getIcon => _icon;
  DateTime get getDateTime => _dateTime;

  set title(String s) {
    _title = s;
  }

  set icon(IconData icon) {
    _icon = icon;
  }

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }
}
