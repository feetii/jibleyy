import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jibley/Models/User.dart';
import 'package:jibley/pages/NavPages/navho.dart';
import 'package:jibley/pages/welcom2.dart';
import 'package:jibley/pages/welcome_page.dart';

import '../pages/NavPages/HomePage.dart';



class AuthController extends GetxController{
  static AuthController instance =Get.find();
  DatabaseReference dbref=FirebaseDatabase.instance.ref().child('Users');
//email.name....
  final user = FirebaseAuth.instance.currentUser;
   late Rx<User?> _user;
  FirebaseAuth auth =FirebaseAuth.instance;

  @override
  Future<void> init()
  async {
    super.onReady();

    _user=Rx<User?> (auth.currentUser)  ;

    //ouer user would be notifed
    _user.bindStream(auth.userChanges());
    ever(_user, _intialiScreen);
  }
  _intialiScreen(User? user )
  async{
    //UserCredential userCredential = (await user?.getIdTokenResult()) as UserCredential;
    if (user==null){
      print("login Page");
      Get.offAll(()=>const WelcomPage2());
    }else{

      print('User ID: ${user.uid}');
      String? userId2 = user.uid;
     // print('Token: ${userCredential.additionalUserInfo}');

      Get.offAll(()=>navho(uid1: userId2,));
    }
  }
  /*void getCurrentUserCredential() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserCredential userCredential = user.providerData[0] as UserCredential;
      print('User ID: ${userCredential.user!.uid}');
      // You can use the userCredential object here to perform other tasks,
      // such as updating the user's profile or sending a verification email.
    }
  }*/

  String userId2 ="" ;

  void register(String email,password,useName)async{
    try {
      UserCredential userCredential=await auth.createUserWithEmailAndPassword(email: email , password: password);
      String uid =userCredential.user!.uid;
      int dt = DateTime.now().millisecondsSinceEpoch;
     /* createUser(useName, email,(String userId)
     {
     userId2=userId;
     print(userId2);
     },uid,dt
     );*/
      creatUser2(useName,email,uid,dt);



    }catch(e){
      Get.snackbar("about User", "user messege",
      snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('Account creation failed',
          style: TextStyle(
            color: Colors.redAccent,
          ),
          ),
        messageText: Text(e.toString(),style: const TextStyle(
          color: Colors.black
        ),
        )
      );

    }

  }
  void login(String email,password)async{
    try {
      UserCredential userCredential =   await auth.signInWithEmailAndPassword(email: email , password: password);


    }catch(e){
      Get.snackbar("about Login", "Login messege",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Account Login failed',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          messageText: Text(e.toString(),style: const TextStyle(
              color: Colors.black
          ),
          )
      );

    }

  }
  void logout()async{
    auth.signOut();
  }
}