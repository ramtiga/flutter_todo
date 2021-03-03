import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Todo(),
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
    // home: ChangeNotifierProvider(
    //   create: (context) => Todo(),
    //   child: MyHomePage(),
    // ));
    // home: MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<Todo>(
    //       create: (context) => Todo(),
    //     ),
    //   ],
    //   child: MyHomePage(),
    // ),
  }
}
