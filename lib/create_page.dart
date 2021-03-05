import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_todo/todo.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  CreatePage({Key key, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final int index;

  @override
  Widget build(BuildContext context) {
    final Todo todo = Provider.of<Todo>(context, listen: false);
    final _icon = Provider.of<ValueNotifier<IconData>>(context, listen: false);
    String _title = "";

    if (index != null) {
      _title = todo.todoList[index].getTitle;
    }

    void _pickIcon() async {
      _icon.value = await FlutterIconPicker.showIconPicker(context);
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
                  onChanged: (value) => _title = value,
                ),
                Consumer<ValueNotifier<IconData>>(
                  builder: (context, value, child) => Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index != null
                            ? Icon(
                                _icon == null
                                    ? todo.todoList[index].getIcon
                                    : _icon.value,
                                size: 45.0,
                              )
                            : (_icon == null
                                ? Text("none")
                                : Icon(
                                    _icon.value,
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
                ElevatedButton(
                  child: index == null ? Text("Add") : Text("Edit"),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    Navigator.pop(
                        context,
                        index == null
                            ? todo.addTodo(_title, _icon.value)
                            : todo.editTodo(_title, _icon.value, index));
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
