


import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void is_login(){
  FirebaseAuth _auth=FirebaseAuth.instance;
  var user=_auth.currentUser;
  if(user == null){
    Get.off(Signin(), transition: Transition.cupertino,duration: Duration(seconds: 1));
  }
  else
    {
      Get.off(Chats(),transition: Transition.cupertino,duration: Duration(seconds: 1));
    }
}

void logout(){
  FirebaseAuth _auth=FirebaseAuth.instance;
  _auth.signOut();
  Get.snackbar(
    "Sign Out Successfully" ,
    "",
    duration: Duration(seconds: 3),
    colorText: Colors.white,


    backgroundColor: Colors.purple.shade500,
  );
  Get.off(Signin(),transition: Transition.fade,duration: Duration(seconds: 1));
}