import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_model.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'create_page.dart';
import 'main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            return Slidable(
              actionExtentRatio: 0.2,
              actionPane: SlidableScrollActionPane(),
              // 左側に表示するWidget
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Archive',
                  color: Colors.lightBlue,
                  icon: Icons.archive,
                  onTap: () {},
                ),
                IconSlideAction(
                  caption: 'share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () {},
                ),
              ],
              // 右側に表示するWidget
              secondaryActions: [
                IconSlideAction(
                  caption: 'More',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: () {
                    //toDoList.remove(data);
                    //setState(() {});
                  },
                ),
                IconSlideAction(
                  caption: '削除',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    //toDoList.remove(data);
                    //setState(() {});
                  },
                ),
              ],

              child: Container(
                decoration: BoxDecoration(color: Colors.deepOrange[400]),
                child: ListTile(
                  leading: Icon(
                    todo.todoList[index].getIcon,
                    color: Colors.white,
                  ),
                  title: Text(todo.todoList[index].getTitle,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          }),
      //body: Container(
      //  child: ReorderableListView(
      //    children: todo.todoList.map((TodoModel todoModel) {
      //      return Container(
      //        key: Key(todoModel.getKey),
      //        decoration: BoxDecoration(color: Colors.deepOrange[400]),
      //        child: ListTile(
      //          leading: Icon(
      //            todoModel.getIcon,
      //            color: Colors.white,
      //          ),
      //          title: Text(
      //            todoModel.getTitle,
      //            style: TextStyle(color: Colors.white),
      //          ),
      //          //trailing: IconButton(
      //          //  icon: Icon(
      //          //    Icons.more_vert,
      //          //    color: Colors.white,
      //          //  ),
      //          //  onPressed: () => showDialog(
      //          //    context: context,
      //          //    builder: (BuildContext context) => AlertDialog(
      //          //      title: Text(
      //          //        todoModel.getTitle,
      //          //        style: TextStyle(color: Colors.white),
      //          //      ),
      //          //      actions: [
      //          //        IconButton(
      //          //            icon: Icon(Icons.delete),
      //          //            color: Colors.indigo,
      //          //            onPressed: () {
      //          //              todo.deleteTodo(todo.todoList.indexOf(todoModel));
      //          //              Navigator.pop(context);
      //          //            }),
      //          //      ],
      //          //    ),
      //          //  ),
      //          //),
      //          onTap: () async {
      //            index = todo.todoList.indexOf(todoModel);
      //            todoWork.copyFromTodo(todo, todoWork, index);
      //            await Navigator.of(context).push(MaterialPageRoute(
      //              builder: (context) => CreatePage(index: index),
      //            ));
      //          },
      //        ),
      //      );
      //    }).toList(),
      //    onReorder: (oldIndex, newIndex) {
      //      todo.dragAndDrop(oldIndex, newIndex);
      //    },
      //  ),
      //),
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
