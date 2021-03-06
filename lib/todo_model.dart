import 'package:flutter/cupertino.dart';

class TodoModel {
  String _title;
  IconData _icon;

  String get getTitle => _title;
  IconData get getIcon => _icon;

  set title(String s) {
    _title = s;
  }

  set icon(IconData icon) {
    _icon = icon;
  }
}
