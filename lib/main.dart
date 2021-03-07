import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_work.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'my_home_page.dart';

final todoProvider = ChangeNotifierProvider((ref) => Todo());
final todoWorkProvider = ChangeNotifierProvider((ref) => TodoWork());

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", "US"),
          const Locale("ja", "JP")
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}
