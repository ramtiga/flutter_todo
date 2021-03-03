import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/todo_model.dart';

class Todo with ChangeNotifier {
  List<TodoModel> todoList = [];

  void addTodo(String title, {IconData icon}) {
    TodoModel todoModel = TodoModel(title, icon);
    todoList.add(todoModel);
    notifyListeners();
  }
}
