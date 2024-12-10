
import 'package:chat_sphere/uihelper/inbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  User? currentUser;

  User? CurrentUser(){
    if(_auth.currentUser!=null){
      currentUser=_auth.currentUser;

    }
    return currentUser;
  }

  final myusers=FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,

        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
        title: Text("Contacts"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
              stream: myusers,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasError){
                  return Text("Check your network connection");
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Text("Loading....");
                }

                return ListView.builder(itemBuilder: (context, index) {
                  String username=snapshot.data!.docs[index]['username'];
                  String email=snapshot.data!.docs[index]['email'];
                  String id=snapshot.data!.docs[index]['uid'];

                  if(snapshot.data!.docs[index]['email'] == CurrentUser()!.email.toString()){
                    return SizedBox(height: 1,);
                  }

                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(snapshot.data!.docs[index]['username']),
                    subtitle: Text(snapshot.data!.docs[index]['email']),
                    trailing: Icon(Icons.contact_mail),
                    onTap: (){
                      Get.to(Inbox(reciever: username,recieverEmail: email,recieverID: id));

                    },

                  );

                },

                itemCount: snapshot.data!.docs.length,);

              },),
        ),
      ),
    );
  }
}
