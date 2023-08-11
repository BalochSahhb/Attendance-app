import 'dart:ui';
import 'package:ezilline_project/student_attendance.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'account_screen.dart';
import 'package:flutter/material.dart';
import 'attendance.dart';

class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({Key? key}) : super(key: key);

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      backgroundColor: Colors.white,

      body:Column(
          children: [Stack(
            children: [
              Container(

                width: double.infinity,
                height: 220,

                decoration: BoxDecoration(
                    color: Colors.pink[600],
                    borderRadius: BorderRadius.only(topLeft: Radius.zero, topRight: Radius.zero,
                      bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40),
                    )
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Container(
                  child: Text('Eziline', style: TextStyle(fontSize: 25,
                      fontFamily: 'Victor',  color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              Positioned(
                top: 70,
                left: 20,
                child: Container(
                  child: Text("teacher's", style: TextStyle(fontSize: 25,
                      fontFamily: 'Victor',  color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),

              Positioned(
                top: 115,
                left: 20,
                child: Container(
                  child: Text('Panel', style: TextStyle(fontSize: 25,
                      fontFamily: 'Victor',  color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              Positioned(
                left: 150,

                child: Container(
                  child: Lottie.network('https://lottie.host/acd3466a-42ed-4adc-9f19-bd20ad7192b2/uFlO8BzGSG.json',
                      width: 250

                  ),
                ),
              )

            ],
          ),
            SizedBox(height: 40,),
            Stack(
                children:[ Container(
                  width: 350,
                  height: 340,
                  decoration: BoxDecoration(
                      color: Colors.pink[600],
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),


                  Positioned(
                    top: 20,
                    left: 30,
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Card(
                        color: Colors.pink[400],
                        elevation: 8,
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Text('Class',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            ),
                            SizedBox(width: 120,),

                            Text('Timing',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            ),

                          ],
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    top: 170,
                    left: 30,
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Card(
                        color: Colors.pink[400],
                        elevation: 8,
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Text('App Dev',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            ),
                            SizedBox(width: 90,),

                            Text('09:00',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 240,
                    left: 30,
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Card(
                        color: Colors.pink[400],
                        elevation: 8,
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Text('Web Dev',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            ),
                            SizedBox(width: 90,),

                            Text('01:00',

                              style: TextStyle(fontFamily: 'YsabeauOffice', fontSize: 25,
                                fontWeight: FontWeight.bold, color: Colors.white,

                              ),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),




                ]
            ),
            SizedBox(
              height: 15,
            ),
            Container(

                width: 350,
                height: 50,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentAttendance()));
                }, child: Text('Check Attendance List',
                  style: TextStyle(fontFamily: 'Victor', fontSize: 15,
                  fontWeight: FontWeight.bold),



                ))

            )

          ]
      ),
    );
  }
}
