import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:todo_six_pm/login_screen.dart';
import 'package:todo_six_pm/splsh_screen.dart';

import 'package:todo_six_pm/task_list_screen.dart';

import 'add_note123.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const SplashScreen()
            : const TaskListScreen());
  }
}
