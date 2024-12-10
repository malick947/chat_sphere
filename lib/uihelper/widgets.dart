import 'package:chat_sphere/uihelper/constant_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
