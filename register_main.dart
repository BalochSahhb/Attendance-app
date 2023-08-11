import 'package:ezilline_project/student_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({Key? key}) : super(key: key);

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {

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
              child:
              Center(child: Lottie.network('https://lottie.host/0d94b56b-b153-4281-a676-36182ce12a34/Ir5h2bx1Q3.json'
                  , width: 250
              )),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.pink[600],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomRight: Radius.circular(45.0),
                      bottomLeft: Radius.zero)),
            ),

            Positioned(
              top: 450,
              left: 40,
              child: Container(
                width: 330,
                height: 60,
                child:ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignIn()));
                  }, child: Text('Student',
                style: (TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20, fontFamily: 'Victor'
                )),
                ),
                )  ,
              ),
            ),


            Positioned(
              top: 550,
              left: 40,
              child: Container(
                width: 330,
                height: 60,
                child:ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherSignIn()));
                  }, child: Text('Teacher',
                    style: (TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 20, fontFamily: 'Victor'
                )),),
                )  ,
              ),
            ),


                  ],
                ),
              ),
            );
  }
}
