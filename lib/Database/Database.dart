
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{

  DBhelper._();

  static final DBhelper getInstance=DBhelper._();

  String USERS_TABLE='USERS';
  String COL_USERNAME='Username';
  String COL_EMAIL='Email';
  String COL_PASSWORD='Password';
  String COL_UID='UID';
  String COL_ID='ID';

  //create database object
  Database? DB;
  //Check database is already or not
  Future<Database> getDB() async {
    if(DB!=null){
      return DB!;
    }
    else
      {
        DB=await OpenDB();
        return DB!;
      }
  }

  Future<Database> OpenDB() async {
    Directory appDir=await getApplicationDocumentsDirectory();
    String DBdir= join(appDir.path,'Users.db');
    DB = await openDatabase(DBdir,onCreate: (db,version){
      db.execute('create Table $USERS_TABLE($COL_ID integer primary key autoincrement,'
          '$COL_UID text not null, '
          '$COL_EMAIL text not null,'
          '$COL_USERNAME text not null,'
          '$COL_PASSWORD text)');

    },version: 1);
    return DB!;
  }


  Future<bool> addUser ({required String UID,required String Email,required String username,required String password}) async {
      var DB=await getDB();
      int val= await DB.insert(USERS_TABLE, {
      COL_UID : UID,
      COL_USERNAME :username,
      COL_EMAIL : Email,
      COL_PASSWORD : password
    });
      if(val > 0){
        debugPrint("USer added");
        return true;
      }
      else{
        return false;
      }
  }
  Future<List<Map<String, dynamic>>> GetUsers() async {
    var db=await getDB();

    List<Map<String,dynamic>> All_Users=await db.query(USERS_TABLE);
    return All_Users;

  }

  //If not then create and creation will be for only one time when application runs for the first time
}