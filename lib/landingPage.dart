import 'dart:async';
import 'dart:convert';
import 'package:cliniflow/nav.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

  class SplashState extends State<SplashScreen> {
  bool isAuthenticated=false;

  
  @override
  void initState() {
  super.initState();


  startTime();
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
    }
    route() {
      
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => nav()
          )
        );
      
      
      
  }

  initScreen(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double imageHeight = screenHeight * 0.7; // 70% of the screen height

  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: imageHeight,
            child: Image.asset("Assets/lp.png"),
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 1,
          )
        ],
      ),
    ),
  );
}
}