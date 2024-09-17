import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_news_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  void  initState(){
    super.initState();

    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen()));
    });
  }



  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.fill,
              width: width * 1,
              height: height * .8,
            ),
            SizedBox(height: height * 0.04,),
            Text('TOP HEADLINES',style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey.shade700),),
            SizedBox(height: height * 0.04,),
            SpinKitChasingDots(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
