import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_sphere/Services/message_Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../State_Management/Theme_Provider.dart';

class Inbox extends StatefulWidget {

  String reciever;
  String recieverEmail;
  String recieverID;

  Inbox({ required this.reciever, required this.recieverEmail,required this.recieverID});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  var stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream=getmessages(widget.recieverID, _auth.currentUser!.uid);

  }
  var message=TextEditingController();
  var MessageAlignment;


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<Theme_Provider>(context, listen: true);
    double Total_height=MediaQuery.of(context).size.height;
    double Total_width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 10,
        title: Text(widget.reciever, style: TextStyle(fontSize: 25,color: Colors.black),),
      ),
      body: Stack(

        children: [
        Center(
          child: Container(
            color: Colors.white,
            child: StreamBuilder(
              stream: stream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasError){
                  return Text("Check your network connection");
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator(color: Colors.purple,);
                }
                if(snapshot.data!.docs.isEmpty){
                  return Text("No Mesage to Show");
                }

                return ListView.builder(itemBuilder: (context, index) {

                  String Message=snapshot.data!.docs[index]['message'];
                  String senderId=snapshot.data!.docs[index]['senderID'];
                  bool isSentByUser = senderId == _auth.currentUser!.uid;
                  var Sender_forecolor=Colors.white;
                  var Sender_backcolor=Colors.purple.shade700;
                  var reciever_forecolor=Colors.black;
                  var reciever_backcolor=Colors.grey.shade200;


                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: BubbleSpecialThree(
                        text:Message,
                        isSender: isSentByUser,
                        color: isSentByUser ? Sender_backcolor : reciever_backcolor,
                        textStyle: TextStyle(color: isSentByUser ? Sender_forecolor : reciever_forecolor,
                        fontSize: 16),
                    ),
                  );



                },

                  itemCount: snapshot.data!.docs.length,);

              },),
          ),
        ),

      ],),
      bottomNavigationBar: BottomAppBar(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(

                  cursorColor: Colors.purple.shade700,
                  controller: message,
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,size: 27,color: themeProvider.getThemeColor(),),
                onPressed: () async {
                  await sendMessage(widget.recieverID, message.text.toString(),widget.recieverEmail);
                  message.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
