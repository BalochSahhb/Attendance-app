import 'package:ezilline_project/student_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'signed_up.dart';
import 'signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        backgroundColor: Colors.red, // You can customize the color here
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
                  child: Lottie.network(
                    'https://lottie.host/50a5dd4a-3958-4d1f-a6ed-5ef658143411/eU7MoxbWeJ.json',
                    width: 250,
                  )),
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

                            // Create a new document in Firestore for the student with their role as 'student'
                            await FirebaseFirestore.instance.collection('register').doc(credential.user!.uid).set({
                              'name': _name.text,
                              'email': email,
                              'role': 'student',
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignedUp()),
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
                          MaterialPageRoute(builder: (context) => SignIn()),
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
