
import 'package:chat_sphere/Database/Database.dart';
import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../uihelper/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  DBhelper database=DBhelper.getInstance;

  var _formkey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var username = TextEditingController();
  bool loading = false;



  void updateUserCollection() async{
    final users=FirebaseFirestore.instance.collection('Users');
     await users.doc(_auth.currentUser!.uid).set({
      'uid' : _auth.currentUser!.uid,
      'email' : email.text.toString(),
      'username' : username.text.toString()

    });
  }
  void signUp() async {
    setState(() {
      loading = true;
    });

    try {
      FirebaseAuth _auth=FirebaseAuth.instance;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Call updateUserCollection to store user details

      updateUserCollection();
      setState(() {
        loading = false;
      });
      // adding into database
      database.addUser(UID: _auth.currentUser!.uid.toString(),
          Email: email.text.toString(),
          username: username.text.toString(),
          password: password.text.toString());

      Get.snackbar(
        "User Created",
        "Account created successfully!",
        duration: Duration(seconds: 3),
        icon: Icon(Icons.verified_user),
        backgroundColor: Colors.purple.shade500,
        colorText: Colors.white
      );

      Get.off(Chats(LoginedUser: userCredential.user!,),transition: Transition.fadeIn,duration: Duration(seconds: 1));
    } catch (e) {
      setState(() {
        loading = false;
      });

      Get.snackbar(
        "Signup Failed",
        e.toString(), // Display the error message
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
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
                          "SignUp, To Create your sphere",
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: height / 4,
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
                                      return "Enter Username";
                                    }
                                    return null;
                                  },
                                  controller: username,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    prefixIcon: Icon(Icons.verified_user),
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
                                  controller: password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
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

                                  text: 'SignUp',
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      signUp();
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
                            Text("Already have account?"),
                            TextButton(
                                onPressed: () {
                                  Get.to(Signin(),transition: Transition.rightToLeft,duration: Duration(seconds: 1));
                                },
                                child: Text("SignIn"))
                          ],
                        )
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
