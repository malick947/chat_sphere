import 'package:chat_sphere/Services/Settings.dart';
import 'package:chat_sphere/Services/login_service.dart';
import 'package:chat_sphere/Services/message_Service.dart';
import 'package:chat_sphere/Splash_Screen.dart';
import 'package:chat_sphere/State_Management/Theme_Provider.dart';
import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Contacts.dart';
import 'package:chat_sphere/uihelper/chatbubble.dart';
import 'package:chat_sphere/uihelper/myUserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'inbox.dart';


class Chats extends StatefulWidget {
  User? LoginedUser;
  Chats({required User this.LoginedUser});

  @override
  State<Chats> createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  User? logUser;
  bool isDataLoaded=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  late var myusers;


  Future<void> GetChatData() async {
    myusers=await FirebaseFirestore.instance.collection('Users').snapshots();

        setState(() {
          isDataLoaded=true;
        });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logUser=widget.LoginedUser;
    GetChatData();



  }
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<Theme_Provider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(

        foregroundColor: Colors.white,
        backgroundColor: themeProvider.color,
        title: Text("Chats" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Optional padding
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: themeProvider.getThemeColor(), // Background color of the header
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ChatSphere',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings, size: 35,color: themeProvider.getThemeColor(),),
              title: Text('Settings',style: TextStyle(fontSize: 20,color: themeProvider.getThemeColor()),),
              onTap: () {
                // Close the drawer and perform action
                  Get.to(Setting());
              },

            ),
            ListTile(
              leading: Icon(Icons.account_box,color: themeProvider.getThemeColor(),size: 35,),
              title: Text("Me",style: TextStyle(fontSize: 20,color: themeProvider.getThemeColor())),
              onTap: (){

                debugPrint(themeProvider.color.toString());  // Ensure `color` is a valid property
              },
            ),


            Divider(), // Optional divider
            ListTile(
              leading: Icon(Icons.exit_to_app,size: 35,color: themeProvider.getThemeColor(),),
              title: Text('Logout',style: TextStyle(fontSize: 20,color: themeProvider.getThemeColor()),),
              onTap: () {
                // Close the drawer and perform action
                logout();
              },
            ),
          ],
        ),
      ),
      body:Container(

        child: Center(
          child:isDataLoaded ?  StreamBuilder(
            stream: myusers,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasError){
                return Text("Check your network connection");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }

              return ListView.builder(itemBuilder: (context, index) {
                String username=snapshot.data!.docs[index]['username'];
                String email=snapshot.data!.docs[index]['email'];
                String id=snapshot.data!.docs[index]['uid'];

                if(snapshot.data!.docs[index]['email'] == logUser!.email.toString()){
                  return SizedBox(height: 0,);
                }

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),

                  child: ListTile(

                    leading: Icon(Icons.person),
                    title: Text(snapshot.data!.docs[index]['username'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                    trailing: Icon(Icons.chat_outlined),
                    onTap: (){
                      Get.to(Inbox(reciever: username,recieverEmail: email,recieverID: id),transition: Transition.leftToRight,duration: Duration(milliseconds: 650));

                    },

                  ),
                );

              },


                itemCount: snapshot.data!.docs.length,);

            },) : CircularProgressIndicator()
        ),
      ),

    );

  }
}
