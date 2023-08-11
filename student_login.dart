import 'package:ezilline_project/student_dashboard.dart';
import 'package:ezilline_project/student_signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherSignIn extends StatefulWidget {
  const TeacherSignIn({Key? key}) : super(key: key);

  @override
  State<TeacherSignIn> createState() => _TeacherSignInState();
}

class _TeacherSignInState extends State<TeacherSignIn> {
  String name = '', email = '', pass = '';

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
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
                // Replace with Lottie animation URL for teacher sign-in
                child: Text('Teacher Sign-In'),
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
              padding: const EdgeInsets.only(top: 350.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: TextFormField(
                          controller: _emailController,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            errorText: _validate ? 'Email Can\'t Be Empty' : null,
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
                          controller: _passController,
                          onChanged: (value) {
                            pass = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            errorText: _validate ? 'Password Can\'t Be Empty' : null,
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );

                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: pass,
                            );

                            // Get the user document from Firestore
                            final userDoc = await FirebaseFirestore.instance.collection('register').doc(credential.user!.uid).get();

                            // Check if the user has the 'role' field set to 'teacher'
                            if (userDoc.exists && userDoc.get('role') == 'teacher') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => StudentDashBoard()),
                              );
                            } else {
                              _showSnackBar('You are not authorized to access this portal.');
                              // Sign out the user since they are not a teacher
                              await FirebaseAuth.instance.signOut();
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              _showSnackBar('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              _showSnackBar('Wrong password provided for that user.');
                            } else {
                              _showSnackBar('Error: ${e.message}');
                            }
                          } catch (e) {
                            _showSnackBar('An unexpected error occurred.');
                            print(e);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontFamily: "YsabeauOffice", fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherSignUp()),
                        );
                      },
                      child: Text('Sign Up'),
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
