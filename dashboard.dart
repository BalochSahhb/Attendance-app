import 'dart:ui';
import 'package:ezilline_project/userprofile.dart';
import 'package:lottie/lottie.dart';
import 'userprofile.dart';
import 'account_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'attendance.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        backgroundColor: Colors.deepPurple,
        bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.deepPurple,
            color: Colors.deepPurple.shade200,
            items: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.home,
                  size: 25,
                ),
              ),
              GestureDetector(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendance()));
              }, child: Icon(Icons.add, size: 35)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                },
                child: Icon(
                  Icons.person,
                  size: 25,
                ),
              ),
            ]),
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
                top: 80,
                left: 20,
                child: Container(
                  child: Text("Student's", style: TextStyle(fontSize: 25,
                      fontFamily: 'Victor',  color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),

              Positioned(
                top: 130,
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

                          )
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
          ]
        ),
    );
  }
}
