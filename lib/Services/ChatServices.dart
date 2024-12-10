
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

Future<List<String>> fetchUsers(String uid1, String uid2) async {
  // Fetch the snapshot from the Users collection
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').get();

  // Convert the snapshot into List<Map<String, dynamic>>
  List<Map<String, dynamic>> userData = snapshot.docs.map((doc) {
    return {
      'uid': doc['uid'],         // Accessing uid field
      'email': doc['email'],     // Accessing email field
      'username': doc['username'], // Accessing username field
    };
  }).toList();


  List<String> Usernames=[' ',' '];
  for(int i=0; i< userData.length;i++){
    if(uid1==userData[i]['uid']){
      Usernames[0]=userData[i]['username'];
    }
    if(uid2==userData[i]['uid']){
      Usernames[1]=userData[i]['username'];
    }
  }
  return Usernames;

}
