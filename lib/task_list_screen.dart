// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:todo_six_pm/add_note123.dart';

import 'package:todo_six_pm/login_screen.dart';
import 'package:todo_six_pm/profile_screen.dart';
 


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({suSignupey});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
   TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();
   

final fb = FirebaseDatabase.instance;
  var l;
  var g;
  var k;
  @override
   

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('todos');

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
           
          IconButton(
              onPressed: (() {
                showDialog(
                    context: context,
                    builder: ((context) {
                      // ignore: prefer_const_constructors
                      return AlertDialog(
                        title: Text('Confirmation !!!'),
                        content: Text('Are You Sure To Log Out ?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) => LoginScreen())));
                                        
                              },
                              child: Text('Yes'))
                        ],
                      );
                    }));
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return addnote();
            }));
          }
        },
        child: Icon(Icons.add),
      ),
      body:   FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var v =
              snapshot.value.toString(); // {subtitle: webfun, title: subscribe}

          g = v.replaceAll(
              RegExp("{|}|subtitle: |title: "), ""); // webfun, subscribe
          g.trim();

          l = g.split(','); // [webfun,  subscribe}]

          return GestureDetector(
            onTap: () {
              setState(() {
                k = snapshot.key;
              });

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: second,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'title',
                      ),
                    ),
                  ),
                  content: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextField(
                      controller: third,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'sub title',
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      color: Color.fromARGB(255, 0, 22, 145),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await upd();
                        Navigator.of(ctx).pop();
                      },
                      color: Color.fromARGB(255, 0, 22, 145),
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                    onPressed: () {
                      
                      showDialog(
                    context: context,
                    builder: ((context) {
                      // ignore: prefer_const_constructors
                      return AlertDialog(
                        title: Text('Confirmation !!!'),
                        content: Text('Are You Sure you want To delete?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                               ref.child(snapshot.key!).remove();
                                 Navigator.pop(context);
                                        
                              },
                              child: Text('Yes'))
                        ],
                      );
                    }));
                    },
                  ),
                  title: Text(
                    l[1],
                    // 'dd',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    l[0],
                    // 'dd',

                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "title": second.text,
      "subtitle": third.text,
    });
    second.clear();
    third.clear();
  }
}
   
