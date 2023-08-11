import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin_screen.dart';
import 'dashboard.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            child: Center(child: Lottie.network('https://lottie.host/da9eb246-2161-4e0d-9c10-31e1ef8ee95a/8Kf5nxIkxl.json'
                , width: 200

            )),
            width: double.infinity,
            height: 350,
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
          left: 30,
          child: Container(
            width: 350,
            height: 80,

            child: Card(

              child: Center(
                child: Text("Muhammad Baloch",

                style: TextStyle(fontFamily:'YsabeauOffice',
                fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
               elevation: 10,
              color: Colors.white,
            ),
          ),
        ),

        Positioned(
          top: 550,
          left: 30,
          child: Container(
            width: 350,
            height: 80,

            child: Card(
              child: Center(
                child: Text("muhammad@gmail.com",

                  style: TextStyle(fontFamily:'YsabeauOffice',
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
         elevation: 10,
              color: Colors.white,
            ),
          ),
        ),

        Positioned(
          top: 650,
          left: 160,

          child: ElevatedButton(onPressed: (){
        FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignIn())));

          }, child: Text('Logout')),
        )

      ],
    );
  }
}
