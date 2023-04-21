// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_six_pm/signup_screen.dart';
import 'package:todo_six_pm/task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  var Emailcontroller = TextEditingController();
  var PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Please'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: Emailcontroller,
              decoration: InputDecoration(hintText: "Email",prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: PasswordController,
              decoration: InputDecoration(hintText: "Password",prefixIcon: Icon(Icons.lock),suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),),
              obscureText: showPassword,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var Email = Emailcontroller.text.trim();
                  var Password = PasswordController.text.trim();

                  if (Email.isEmpty || Password.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please Fill All Fields');
                    return;
                  }
                  final ProgressDialog pr = ProgressDialog(
                    context,
                  );
                  pr.style(message: 'Logging In');
                  await pr.show();

                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    UserCredential userCredential =
                        await auth.signInWithEmailAndPassword(
                            email: Email, password: Password);
                    if (userCredential.user != null) {
                      pr.hide().then((isHidden) {
                      print(isHidden);
                    });
                      

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => TaskListScreen())));
                      
                    }
                  } on FirebaseAuthException catch (e) {
                    pr.hide().then((isHidden) {
                      print(isHidden);
                    });

                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(msg: 'User Not Found');
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(msg: 'Wrong Password');
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Something Went Wrong');
                  }

                  
                },
                child: Text('Login')),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not Registered Yet ?'),
                TextButton(
                    onPressed: (() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    }),
                    child: Text('Register Now'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
