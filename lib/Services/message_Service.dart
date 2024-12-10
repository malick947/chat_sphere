
import 'package:chat_sphere/Services/Message_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> sendMessage(String recieverID,String message,String recieverEmail) async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  User? user=_auth.currentUser!;
  String senderId=user.uid;

  String senderEmail=user.email!;
  final Timestamp timestamp=Timestamp.now();
  Message newMessage=Message(
      senderID: senderId,
      recieverID: recieverID,
      senderEmail: senderEmail,
      recieverEmail: recieverEmail,
      message: message);

  // creating chat room and adding message to firestore
  List<String> ids=[senderId,recieverID];
  ids.sort();
  String chatID=ids.join('-');
  /* await _firestore.collection('ChatRoom').doc(chatID).collection('Messages').add(newMessage.toMap()).then((value){

  },onError: (){}); */
  final chatRoomRef = _firestore.collection('ChatRoom').doc(chatID);
  await chatRoomRef.set({
    'participant1' : senderId,
    'participant2' : recieverID
  }, SetOptions(merge: true));
  await chatRoomRef.collection('Messages').add(newMessage.toMap());


}

Stream<QuerySnapshot> getmessages(String recieverID,String senderID) {
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  
  
  
  List<String> ids=[senderID,recieverID];
  ids.sort();
  String ChatID=ids.join("-");

  return _firestore.collection("ChatRoom").doc(ChatID).collection("Messages").orderBy('timestamp').snapshots();

}

Stream<QuerySnapshot> LoadingChats() {

  FirebaseFirestore _firestore=FirebaseFirestore.instance;


  return _firestore.collection('ChatRoom').snapshots();

}

