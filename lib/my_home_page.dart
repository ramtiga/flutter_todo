import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'create_page.dart';
import 'main.dart';

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = useProvider(todoProvider);
    final TodoWork todoWork = useProvider(todoWorkProvider);

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
                  border: Border.all(width: 1.0, color: Colors.indigo)),
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
                            color: Colors.indigo,
                            onPressed: () {
                              todo.deleteTodo(index);
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  todoWork.copyFromTodo(todo, todoWork, index);
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
