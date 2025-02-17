

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
class Google_Auth_Service{

  Future<void> updateUser(String email,String username) async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    final users=FirebaseFirestore.instance.collection('Users');
    await users.doc(_auth.currentUser!.uid).set({
      'uid' : _auth.currentUser!.uid,
      'email' : email,
      'username' : username

    });
  }

  Future<UserCredential?> SignInwithGoogle() async {
    FirebaseAuth _auth=FirebaseAuth.instance;

    try{
      final googleuser=await GoogleSignIn().signIn();
      final authentic_user=await googleuser?.authentication;

      final cred=GoogleAuthProvider.credential(idToken: authentic_user!.idToken,accessToken: authentic_user!.accessToken);


      return _auth.signInWithCredential(cred);

    }catch(e){
      Get.snackbar("We are facing some issues", 'while authenticating with Google');
      return null;
    }

  }
}