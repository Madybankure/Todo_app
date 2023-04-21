 // ignore_for_file: prefer_const_constructors

 import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_six_pm/task_list_screen.dart';
import 'main.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('todos/$k');

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [IconButton(onPressed:  () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder:  ((context) => TaskListScreen())));
        }, icon: Icon(Icons.arrow_back)),
          Title(color: Colors.blue, child: Text('Add Todos')),
        ],)
         
        
      ),
      body: Container(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: second,
                decoration: InputDecoration(prefixIcon: Icon(Icons.title),
                  hintText: 'Title',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: third,
                decoration: InputDecoration(prefixIcon: Icon(Icons.subtitles),
                  hintText: 'Sub Title',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
            color: Colors.blue,
              onPressed: () {
                ref.set({
                  "title": second.text,
                  "subtitle": third.text,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => TaskListScreen()));
              },
              // ignore: prefer_const_constructors
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}