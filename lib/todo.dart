import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/todo_model.dart';
import 'package:flutter_todo/todo_work.dart';

class Todo with ChangeNotifier {
  List<TodoModel> todoList = [];
  IconData icon;

  void addTodo(TodoWork todoWork) {
    TodoModel todoModel = new TodoModel();
    todoModel.title = todoWork.getTitle;
    todoModel.icon = todoWork.getIcon;
    todoList.add(todoModel);
    notifyListeners();
  }

  void editTodo(TodoWork todoWork, int index) {
    todoList.removeAt(index);

    TodoModel todoModel = new TodoModel();
    todoModel.title = todoWork.getTitle;
    todoModel.icon = todoWork.getIcon;
    todoList.insert(index, todoModel);

    notifyListeners();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
    notifyListeners();
  }
}
