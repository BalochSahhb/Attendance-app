import 'package:ezilline_project/signed_up.dart';
import 'package:ezilline_project/student_login.dart';
import 'package:ezilline_project/student_signed_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherSignUp extends StatefulWidget {
  const TeacherSignUp({Key? key}) : super(key: key);

  @override
  State<TeacherSignUp> createState() => _TeacherSignUpState();
}

class _TeacherSignUpState extends State<TeacherSignUp> {
  String email = '', pass = '';
  final _name = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              child: Center(
                // Replace with Lottie animation URL for teacher sign-up
                child: Text('Teacher Sign-Up'),
              ),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.pink[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomRight: Radius.circular(45.0),
                  bottomLeft: Radius.zero,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: TextFormField(
                          controller: _name,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            labelText: 'Enter Your name',
                            hintText: 'Enter your name',
                            errorText: _validate ? 'Value Can\'t Be Empty' : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 6, color: Colors.black),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email),
                            labelText: 'Enter Your email',
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 6, color: Colors.black),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: TextFormField(
                          onChanged: (value) {
                            pass = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock),
                            labelText: 'Create a password',
                            hintText: 'Create a Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 6, color: Colors.black),
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pink,
                        ),
                        onPressed: () async {
                          setState(() {
                            _name.text.isEmpty ? _validate = true : _validate = false;
                          });

                          if (_validate) {
                            _showSnackBar('Please enter your name.');
                            return; // Return early if name field is empty
                          }

                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );

                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: pass,
                            );

                            // Create a new document in Firestore for the teacher with their role as 'teacher'
                            await FirebaseFirestore.instance.collection('register').doc(credential.user!.uid).set({
                              'name': _name.text,
                              'email': email,
                              'role': 'teacher',
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentSignedUp()),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              _showSnackBar('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              _showSnackBar('The account already exists for that email.');
                            } else {
                              _showSnackBar('Error: ${e.message}'); // Show other FirebaseAuthExceptions
                            }
                          } catch (e) {
                            _showSnackBar('An unexpected error occurred.'); // Show generic error
                            print(e);
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontFamily: "YsabeauOffice", fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherSignIn()),
                        );
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
