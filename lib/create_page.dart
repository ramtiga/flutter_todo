import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_todo/todo.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  final int index;
  const CreatePage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Todo todo = Provider.of<Todo>(context, listen: false);
    final _icon = Provider.of<ValueNotifier<IconData>>(context, listen: false);
    String _title = "";

    if (index != null) {
      _title = todo.todoList[index].getTitle;
      _icon.value = todo.todoList[index].getIcon;
    }

    void _pickIcon() async {
      _icon.value = await FlutterIconPicker.showIconPicker(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create TODO"),
      ),
      body: Container(
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
              TextField(
                controller: TextEditingController(
                    text: index != null ? todo.todoList[index].getTitle : ""),
                decoration: InputDecoration(labelText: "TODO title"),
                onChanged: (String text) => _title = text,
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
                          : (index == null ? Text("none") : _icon.value),
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
    );
  }
}

class CreatePage0 extends StatefulWidget {
  @override
  _CreatePage0State createState() => _CreatePage0State();
}

class _CreatePage0State extends State<CreatePage0> {
  String _title = "";
  IconData _icon;
  bool _isError = false;

  void _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context);
    setState(() {
      _icon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create TODO"),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "TODO title"),
                onChanged: (String text) => _title = text,
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _icon != null
                        ? Icon(
                            _icon,
                            size: 45.0,
                          )
                        : Text("none"),
                    ElevatedButton(
                      child: const Text("Pick Icon"),
                      onPressed: () => _pickIcon(),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text("Add"),
                onPressed: () {
                  if (_title == "" || _icon == null) {
                    setState(() {
                      _isError = true;
                    });
                    return;
                  }
                  // Navigator.pop(context, Todo(_title, _icon));
                },
              ),
              if (_isError)
                Text(
                  "すべての項目を入力してください",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
