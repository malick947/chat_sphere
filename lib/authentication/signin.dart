import 'package:chat_sphere/Database/Database.dart';
import 'package:chat_sphere/Services/login_service.dart';
import 'package:chat_sphere/authentication/signup.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:chat_sphere/uihelper/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';



class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  FirebaseAuth _auth=FirebaseAuth.instance;

  bool loading =false;

  
  final _formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> login() async {
    if (!_formkey.currentState!.validate()) return;

    try {
      setState(() {
        loading = true;
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      setState(() {
        loading = false;
      });

      Get.off(Chats(LoginedUser: userCredential.user!));
    } catch (error) {
      setState(() {
        loading = false;
      });

      Get.snackbar(
        'Login Error',
        error.toString(),
        backgroundColor: Colors.purple.shade500,
        colorText: Colors.white,
        icon: Icon(Icons.error),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: height / 6,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ChatSphere",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "SignIn, Update yourself !!!",
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: height / 3,
                    color: Colors.white,
                    child: Lottie.asset('assets/animations/loginani.json'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Email";
                                    }
                                    return null;
                                  },

                                  controller: email,
                                  decoration: InputDecoration(

                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(

                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.purple),
                                    ),
                                  ),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
                                  controller: password,
                                  decoration: InputDecoration(

                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.purple),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: RoundButton(
                                  text: 'SignIn',
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                     await login();
                                    }
                                  },
                                  loading: loading,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Don't have account?"),
                          TextButton(onPressed: (){
                                  Get.to(Signup(),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                          }, child: Text("SignUP"))
                        ],)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
