

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String recieverEmail;
  late String senderID;
  late String recieverID;
  late String senderEmail;


  late String message;
  Timestamp timestamp=Timestamp.now();

  Message({required this.senderID,required this.recieverID,required this.senderEmail,required this.message,required this.recieverEmail});

  Map<String,dynamic> toMap(){
    return {
      'senderID' : senderID,
      'recieverID' : recieverID,
      'senderEmail' : senderEmail,
      'recieverEmail' : recieverEmail,
      'message' : message,
      'timestamp' : timestamp

    };
  }

}