

import 'package:chat_sphere/authentication/Google_Auth.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isloaded=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: ElevatedButton(onPressed: () async {

        isloaded=true;
        Get.to(Chats);
      }, child: isloaded ? Text("SignIn with Google") : CircularProgressIndicator()),),
    );
  }
}
