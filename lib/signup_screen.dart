// ignore_for_file: prefer_const_constructors



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({suSignupey});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var fullNameController = TextEditingController();
  var Emailcontroller = TextEditingController();
  var PasswordController = TextEditingController();
  var ConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Please'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(hintText: "Fullname"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: Emailcontroller,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: PasswordController,
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ConfirmController,
              decoration: InputDecoration(hintText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var fullName = fullNameController.text.trim();
                  var email = Emailcontroller.text.trim();
                  var password = PasswordController.text.trim();
                  var Confirmpass = ConfirmController.text.trim();

                  if (fullName.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      Confirmpass.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill All Field');
                    return;
                  }

                  if (password.length < 6) {
                    Fluttertoast.showToast(
                        msg: 'Weak Password Atleast 6 Characters Required');
                    return;
                  }
                  if (password != Confirmpass) {
                    Fluttertoast.showToast(msg: 'Password do not Match');
                    return;
                  }
                   final ProgressDialog pr = ProgressDialog(
                      context,
                    );
                    pr.style(message: 'Signing up');
                    await pr.show();

                  try {
                   

                    FirebaseAuth auth = FirebaseAuth.instance;

                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                    if (userCredential.user != null) {

                      //store data in fromation in realtime data base

                      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users');

                      String? uid =userCredential.user!.uid;
                      int dt = DateTime.now().millisecondsSinceEpoch;


                      userRef.child(uid).set({
                        'fullName': fullName,
                        'email': email,
                        'uid': uid,
                        'dt': dt,
                        'profileImage': ''
                      });






                      Fluttertoast.showToast(msg: 'Success');
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: 'Failed');
                    }
                    pr.hide().then((isHidden) {
                      print(isHidden);
                    });
                  } on FirebaseAuthException catch (e) {
                    
                    pr.hide().then((isHidden) {
                      print(isHidden);
                    });

                    if (e.code == 'email-already-in-use') {
                      Fluttertoast.showToast(msg: 'Email is Already on Use');
                    } else if (e.code == 'weak--Password') {
                      Fluttertoast.showToast(msg: 'Password is Weak');
                    }
                  } catch (e) {
                    
                    pr.hide().then((isHidden) {
                      print(isHidden);
                    });
                    Fluttertoast.showToast(msg: 'Something Went Wrong');
                  }
                },
                child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}
