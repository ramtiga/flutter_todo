import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  CreatePage({Key key, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final int index;

  @override
  Widget build(BuildContext context) {
    final Todo todo = Provider.of<Todo>(context, listen: false);
    final TodoWork todoWork = Provider.of<TodoWork>(context, listen: false);

    //if (index != null) {
    //todoWork.dateTimeWork = todo.todoList[index].getDateTime;
    //}

    void _pickIcon() async {
      todoWork.iconWork = await FlutterIconPicker.showIconPicker(context);
    }

    void _selectDate() async {
      todoWork.dateTimeWork = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
          locale: const Locale("ja"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create TODO"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<Todo>(
                  builder: (context, todo, child) => Text(
                    todo.todoList.length.toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                TextFormField(
                  initialValue:
                      index != null ? todo.todoList[index].getTitle : "",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "タイトルを入力してください";
                    }
                    return null;
                  },
                  onChanged: (value) => todoWork.title = value,
                ),
                Consumer<TodoWork>(
                  builder: (context, todoWork, child) => Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index != null
                            ? Icon(
                                todoWork.getIcon == null
                                    ? todo.todoList[index].getIcon
                                    : todoWork.getIcon,
                                size: 45.0,
                              )
                            : (todoWork.getIcon == null
                                ? Text("none")
                                : Icon(
                                    todoWork.getIcon,
                                    size: 45.0,
                                  )),
                        ElevatedButton(
                          child: const Text("Pick Icon"),
                          onPressed: () => _pickIcon(),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<TodoWork>(
                  builder: (context, todoWork, child) => Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index != null
                            ? todoWork.getDateTime == null
                                ? Text(DateFormat.yMMMd('ja')
                                    .format(todo.todoList[index].getDateTime)
                                    .toString())
                                : Text(DateFormat.yMMMd('ja')
                                    .format(todoWork.getDateTime)
                                    .toString())
                            : (todoWork.getDateTime != null
                                ? Text(DateFormat.yMMMd('ja')
                                    .format(todoWork.getDateTime)
                                    .toString())
                                : Text("")),
                        ElevatedButton(
                            onPressed: () => _selectDate(),
                            child: Text("Date")),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  child: index == null ? Text("Add") : Text("Edit"),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    Navigator.pop(
                        context,
                        index == null
                            ? todo.addTodo(todoWork)
                            : todo.editTodo(todoWork, index));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
