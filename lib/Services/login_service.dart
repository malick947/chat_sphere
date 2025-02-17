


import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:chat_sphere/uihelper/Prev_Account.dart';
import 'package:chat_sphere/uihelper/Sign_in_Options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void is_login(){
  FirebaseAuth _auth=FirebaseAuth.instance;
  User? user=_auth.currentUser;
  if(user == null){
    Get.off(InitialScreen(), transition: Transition.cupertino,duration: Duration(seconds: 1));
  }
  else
    {
      Get.off(Chats(LoginedUser: user,),transition: Transition.cupertino,duration: Duration(seconds: 1));
    }
}

void logout(){
  FirebaseAuth _auth=FirebaseAuth.instance;
  _auth.signOut();
  Get.snackbar(

    "Sign Out Successfully" ,
    "",
    duration: Duration(seconds: 3),
    colorText: Colors.black,




  );
  Get.off(PrevAccount(),transition: Transition.fade,duration: Duration(seconds: 1));
}