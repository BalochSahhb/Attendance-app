import 'package:ezilline_project/register_main.dart';
import 'package:ezilline_project/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 98.0, left: 13.0),
                    child: Text(
                      ' Eziline Attendance ',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'YsabeauOffice',
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/private_files/lf30_wbszjekz.json'
                        , width: 300),
                  ),
                ],
              ),
              color: Colors.blue,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 68.0, left: 60.0),
                    child: Text(
                      'Teacher Can add Attendace ',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'YsabeauOffice',
                          color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_ny7LIo.json'
                        , width: 300),
                  ),
                ],
              ),
              color: Colors.yellow,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 98.0, left: 40),
                    child: Text(
                      'Teacher Can Delete Attendance',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'YsabeauOffice',
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/private_files/lf30_udcuw1v9.json'
                    , width: 300
                    ),
                  ),
                ],
              ),
              color: Colors.pink,
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Container(
            alignment: Alignment(0, 0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterMain()));
                    },
                    child: Text(
                      'skip',
                      style:
                          TextStyle(fontFamily: 'YsabeauOffice', fontSize: 15),
                    )),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterMain()));
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('done',
                            style: TextStyle(
                                fontFamily: 'YsabeauOffice', fontSize: 15)))
                    : GestureDetector(
                        onTap: () {

                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('next',
                            style: TextStyle(
                                fontFamily: 'YsabeauOffice', fontSize: 15))),
              ],
            ))
      ],
    ));
  }
}
