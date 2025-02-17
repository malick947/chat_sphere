import 'package:chat_sphere/Database/Database.dart';
import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Chats.dart';
import 'package:chat_sphere/uihelper/Sign_in_Options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../State_Management/Theme_Provider.dart';

class PrevAccount extends StatefulWidget {
  const PrevAccount({super.key});

  @override
  State<PrevAccount> createState() => _PrevAccountState();
}

class _PrevAccountState extends State<PrevAccount> {
  UserCredential? userCredential;
  User? user;
  List<Map<String, dynamic>> prev_Logged_Users = [];
  DBhelper? database;

  @override
  void initState() {
    super.initState();
    database = DBhelper.getInstance;
    get_Prev_Users();
  }

  Future<void> get_Prev_Users() async {
    List<Map<String, dynamic>> users = await database!.GetUsers();
    setState(() {
      prev_Logged_Users = users;
    });
  }

  @override
  Widget build(BuildContext context) {

    var themeProvider = Provider.of<Theme_Provider>(context, listen: true);

    FirebaseAuth _auth=FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(

        backgroundColor: themeProvider.getThemeColor(),
        automaticallyImplyLeading: false,
        title: Text("Previous Accounts",style: TextStyle(color: Colors.white),),),
      body: prev_Logged_Users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
                  itemCount: prev_Logged_Users.length,
                  itemBuilder: (context, index) {
          return GestureDetector(

            child: ListTile(
              title: Text(
                prev_Logged_Users[index][database!.COL_USERNAME],
                style: TextStyle(color: Colors.black,fontSize: 25),
              ),
              subtitle: Text(prev_Logged_Users[index][database!.COL_EMAIL]),
            ),
              onTap: () async {
                try {
                  UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                    email: prev_Logged_Users[index][database!.COL_EMAIL],
                    password: prev_Logged_Users[index][database!.COL_PASSWORD],
                  );
                  user = userCredential.user;

                  if (user != null) {
                    Get.to(Chats(LoginedUser: user!));
                  } else {
                    Get.snackbar("Error", "User authentication failed");
                  }
                } catch (e) {
                  Get.snackbar("Error", 'Facing difficulties while fetching details: ${e.toString()}');
                }
              },



          );
                  },
                ),
          floatingActionButton: Container(
            height: 60,
            width: 170,

            child: FloatingActionButton(
                child: Text("Another Account",style: TextStyle(fontSize: 15),),
                hoverColor: Colors.grey,
                foregroundColor: Colors.white,

                backgroundColor: themeProvider.getThemeColor(),
                onPressed: (){
              Get.to(InitialScreen(),transition: Transition.leftToRight,duration: Duration(milliseconds:500 ));
            }),
          ),
    );
  }
}
