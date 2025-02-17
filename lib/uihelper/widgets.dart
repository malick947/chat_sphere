import 'package:chat_sphere/uihelper/constant_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final text;
  bool loading;
  RoundButton({required this.text,required this.onTap,this.loading=false});



  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height/13,
        width: width/1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Constants().Appcolor,
        ),
        child:loading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: height/35),)),
      ),
    );
  }
}

class except{
  void excep({String msg="Error"}){
    Fluttertoast.showToast(
        msg:msg,
    toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 3,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 16.0
    );
  }
}

class MySigningButton extends StatelessWidget {
  var col;
  var icon;
  String text;
  final VoidCallback onTap;
  MySigningButton({this.col=Colors.blueAccent, required this.icon, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(height: height/12,
        width: width/1.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(blurRadius: 10,spreadRadius: 1,color: col)
            ]
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          FaIcon(icon,color: col,size: 35,),
          Text(text,style: TextStyle(color: col,fontSize: 15,fontWeight: FontWeight.bold),)
        ],),
      ),
    );
  }
}
class MyappBar extends StatelessWidget {
  var forCol;
  var backCol;
  String title;

  MyappBar({required this.forCol,required this.backCol,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: forCol,
      backgroundColor: backCol,
      title: Text(title , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
      centerTitle: true,
    );
  }
}
