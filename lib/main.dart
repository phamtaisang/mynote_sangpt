import 'package:flutter/material.dart';
import 'package:mynote/ui/views/login/login_view.dart';
import 'package:mynote/ui/views/note/note_view.dart';

void main() {
  runApp(MaterialApp(
    title: "Note",
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyApp(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => PageLogin(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteView(),
    );
  }
}

class PageLogin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
    );
  }
}
