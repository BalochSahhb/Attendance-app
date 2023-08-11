import 'dart:async';

import 'onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'YsabeauOffice-Medium'),
      debugShowCheckedModeBanner: false,
      title: 'Attendance app',
      home: myApp(),
    );
  }
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => onBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[600],
        child: Center(
            child: Text(
              "EZILINE",
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
            )),
      ),
    );
  }
}
