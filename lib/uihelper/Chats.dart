import 'package:chat_sphere/Services/login_service.dart';
import 'package:chat_sphere/Services/message_Service.dart';
import 'package:chat_sphere/Splash_Screen.dart';
import 'package:chat_sphere/authentication/signin.dart';
import 'package:chat_sphere/uihelper/Contacts.dart';
import 'package:chat_sphere/uihelper/chatbubble.dart';
import 'package:chat_sphere/uihelper/myUserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inbox.dart';


class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  User? currentUser;

  final myusers=FirebaseFirestore.instance.collection('Users').snapshots();

  User? CurrentUser(){
    if(_auth.currentUser!=null){
      currentUser=_auth.currentUser;

    }
    return currentUser;
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple.shade700,
        title: Text("Chats" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Optional padding
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple.shade700, // Background color of the header
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ChartSphere',
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
              leading: Icon(Icons.settings, size: 35,color: Colors.purple.shade700,),
              title: Text('Settings',style: TextStyle(fontSize: 20,color: Colors.purple.shade700),),
              onTap: () {
                // Close the drawer and perform action

              },
              
            ),
            ListTile(
              leading: Icon(Icons.account_box,color: Colors.purple.shade700,size: 35,),
              title: Text("Me",style: TextStyle(fontSize: 20,color: Colors.purple.shade700)),
              onTap: (){
                  Get.to(SplashScreen());
              },
            ),
            

            Divider(), // Optional divider
            ListTile(
              leading: Icon(Icons.exit_to_app,size: 35,color: Colors.purple.shade700,),
              title: Text('Logout',style: TextStyle(fontSize: 20,color: Colors.purple.shade700),),
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
          child: StreamBuilder(
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

                if(snapshot.data!.docs[index]['email'] == CurrentUser()!.email.toString()){
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

            },),
        ),
      ),

    );

  }
}
