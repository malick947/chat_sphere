import 'dart:async';

import 'package:chat_sphere/Services/login_service.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){

      is_login();

    });
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8507bb), Color(0xffa169c9)],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )

        ),
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: height/5,horizontal: width/12),
          child: Center(
            child: Column(

              children: [
                Container(
                  width: width/3,
                  height:width/3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        blurRadius: 6,
                        spreadRadius: 5.0
                      )
                    ],
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(image: AssetImage('assets/app-logo.jpg'))
                  ),

                  ),
                  SizedBox(height: 30,),
                Text("ChatSphere",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                ),
                SizedBox(height: 15,),
                Text('Your world of endless connections, all in one Sphere', style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}