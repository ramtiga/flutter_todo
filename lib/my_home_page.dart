import 'package:flutter/material.dart';
import 'package:flutter_todo/create_page.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = Provider.of<Todo>(context);
    final TodoWork todoWork = Provider.of<TodoWork>(context, listen: false);
    //final _icon = Provider.of<ValueNotifier<IconData>>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST App"),
      ),
      body: ListView.builder(
        itemCount: todo.todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.deepOrange)),
              child: ListTile(
                leading: Icon(todo.todoList[index].getIcon),
                title: Text(todo.todoList[index].getTitle),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(todo.todoList[index].getTitle),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.deepOrange,
                            onPressed: () {
                              todo.deleteTodo(index);
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  todoWork.clear();
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreatePage(index: index),
                  ));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //if (_icon != null) _icon.value = null;
          todoWork.clear();
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
