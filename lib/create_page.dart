import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class CreatePage extends HookWidget {
  CreatePage({Key key, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final int index;

  @override
  Widget build(BuildContext context) {
    final Todo todo = useProvider(todoProvider);
    final TodoWork todoWork = useProvider(todoWorkProvider);

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
                Text(
                  todo.todoList.length.toString(),
                  style: TextStyle(fontSize: 40),
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
                Container(
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
                Container(
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
                          onPressed: () => _selectDate(), child: Text("Date")),
                    ],
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
