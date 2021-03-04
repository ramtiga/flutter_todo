import 'package:flutter/material.dart';
import 'package:flutter_todo/todo.dart';
import 'package:provider/provider.dart';
import 'my_home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Todo>(create: (_) => Todo()),
        ChangeNotifierProvider<ValueNotifier<IconData>>(
            create: (_) => ValueNotifier<IconData>(null)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}
