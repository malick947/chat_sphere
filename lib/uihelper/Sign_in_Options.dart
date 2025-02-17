import 'package:chat_sphere/authentication/Facebook_authService.dart';
import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:chat_sphere/uihelper/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../authentication/Google_Auth.dart';
import 'package:get/get.dart';

class InitialScreen extends StatefulWidget {

  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  User? googleUser;
  User? facebookUser;
  final Facebook_auth Auth = Facebook_auth();  // Fixed initialization
  final AuthClass = Google_Auth_Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ChatSphere",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Signin Options",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            MySigningButton(
              icon: FontAwesomeIcons.facebook,
              col: Colors.blueAccent,
              text: "Signin with Facebook",
              onTap: () async {
                facebookUser = await Auth.signInWithFacebook();
                if (facebookUser != null) {
                  Get.off(Chats(LoginedUser: facebookUser!));
                }
              },
            ),
            MySigningButton(
              icon: FontAwesomeIcons.google,
              col: Colors.redAccent,
              text: "Signin with Google",
              onTap: () async {
                googleUser = (await AuthClass.SignInwithGoogle())?.user;
                if (googleUser != null) {
                  Get.off(Chats(LoginedUser: googleUser!));
                }
              },
            ),
            MySigningButton(
              icon: FontAwesomeIcons.user,
              col: Colors.purple,
              text: "Signin with Email",
              onTap: () {
                Get.off(Signin(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 300));
              },
            ),
          ],
        ),
      ),
    );
  }
}
