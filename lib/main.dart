import 'package:covid_assistant/moduels/register_screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'moduels/login/login_screen.dart';
import 'widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /* Bloc.observer = MyBlocObserver();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //closing debug banner
      debugShowCheckedModeBanner: false,
      //adding theme to application
      theme: ThemeData(primarySwatch: Colors.cyan),
      //starting app
      home: WidgetTree(),
      //adding te app routes
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/reg': (context) => registerScreen(),
      },
    );
  }
}
