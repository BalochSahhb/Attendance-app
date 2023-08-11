import 'package:ezilline_project/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignedUp extends StatefulWidget {
  const SignedUp({Key? key}) : super(key: key);

  @override
  State<SignedUp> createState() => _SignedUpState();
}

class _SignedUpState extends State<SignedUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Lottie.network('https://lottie.host/ff0ac53a-4b88-4f83-8148-de06e517266c/cMd3OH19Ek.json'
            , width: 400
            ),

          ),
          Text("Congrats! You've created your accout",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'YsabeauOffice',

            ),

          ),

          SizedBox(height: 10,),
          Text("Tap Login For Sign In",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'YsabeauOffice',

            ),

          ),
          SizedBox(height: 10,),

          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
