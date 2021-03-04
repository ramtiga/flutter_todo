import 'package:flutter/material.dart';
import 'package:flutter_todo/create_page.dart';
import 'package:flutter_todo/todo.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = Provider.of<Todo>(context);

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
                  border: Border.all(width: 1.0, color: Colors.red)),
              child: ListTile(
                leading: Icon(todo.todoList[index].getIcon),
                title: Text(todo.todoList[index].getTitle),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreatePage(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
