import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jibley/Services/authController.dart';

class UserMe {
  // make userId nullable

  final String name;
  final String email;

  late final String uid;
  late final int dt;
  UserMe({required this.name, required this.email,required this.uid,required this.dt});
  UserMe.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        uid = map['uid'],
        dt = map['dt'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid':uid,
      'dt':dt
    };
  }

}
void creatUser2(String name, String email,String uid,int dt)async {
  await FirebaseFirestore.instance.collection("Users").doc(uid).set(UserMe(name: name, email: email,uid: uid,dt: dt).toJson()).then((_) {

  });
  UserMe user = UserMe(name: name, email: email, uid: uid, dt: dt);
}
Future<void> createUser(String name, String email,Function(String) callback,String uid,int dt) async {
  DatabaseReference dbref=FirebaseDatabase.instance.ref().child('Users').child(uid);

 // DatabaseReference newRef = dbref.push(); // generate new Firebase key
  String userId = dbref.key!; // retrieve key from Firebase
 await dbref.set(UserMe(name: name, email: email,uid: uid,dt: dt).toJson()).then((_) {
    callback(userId);
  }); // store user data in Firebase
  // update user object with Firebase-generated key

  //user.userId = userId;
  UserMe user = UserMe(name: name, email: email, uid: uid, dt: dt);
}