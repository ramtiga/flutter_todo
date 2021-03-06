import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/todo_model.dart';

class TodoWork with ChangeNotifier, TodoModel {
  set iconWork(IconData iconData) {
    icon = iconData;
    notifyListeners();
  }

  void clear() {
    title = "";
    icon = null;
  }
}
