import 'package:flutter/cupertino.dart';

class TodoModel {
  String _title;
  IconData _icon;
  DateTime _dateTime;
  String _key;

  String get getTitle => _title;
  IconData get getIcon => _icon;
  DateTime get getDateTime => _dateTime;
  String get getKey => _key;

  set title(String s) {
    _title = s;
  }

  set icon(IconData icon) {
    _icon = icon;
  }

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }

  set key(String key) {
    _key = key;
  }
}
