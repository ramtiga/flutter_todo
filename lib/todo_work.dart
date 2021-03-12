import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_model.dart';

class TodoWork with ChangeNotifier, TodoModel {
  set iconWork(IconData iconData) {
    this.icon = iconData;
    notifyListeners();
  }

  set dateTimeWork(DateTime dateTime) {
    this.dateTime = dateTime;
    notifyListeners();
  }

  void clear() {
    title = "";
    icon = null;
    dateTime = null;
  }

  void copyFromTodo(Todo todo, TodoWork work, int index) {
    work.title = todo.todoList[index].getTitle;
    work.iconWork = todo.todoList[index].getIcon;
    work.dateTimeWork = todo.todoList[index].getDateTime;
    work.key = todo.todoList[index].getKey;
  }
}
