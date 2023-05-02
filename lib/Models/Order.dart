

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

import '../pages/NavPages/navho.dart';

class  Order_product {

  final String adresse, quantity, details,numero, idUser,idOrder,idProduct,pric;



  Order_product({
    required this.idOrder,
    required this.idProduct,
    required this.idUser,
    required this.adresse,
    required this.quantity,
    required this.details,
    required this.numero,
    required this.pric

  });

  Order_product.fromMap(Map<String, dynamic> map)
      : idOrder = map['idOrder'],
        idProduct= map['idProduct'],
        idUser = map['idUser'],
        details = map['details'],
        pric = map['pric'],
        adresse = map['adresse'],
        numero = map['numero'],
        quantity= map['quantity'];




  Map<String, dynamic> toJson() {
    return {
      'idOrder': idOrder,
      'idProduct': idProduct,
      'idUser': idUser,
      'adresse': adresse,
      'quantity': quantity,
      'details': details,
      'numero': numero,
      'pric':pric,

    };
  }
  factory Order_product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Order_product(
      idOrder: doc.id,
      idUser: data['idUser'] ?? '',
      idProduct: data['idProduct'] ?? '',
      pric: (data['pric'] ?? 0.0).toString(),
      numero: (data['numero'] ?? 0.0).toString(),
      details: data['details'] ?? '',
      adresse: data['adresse'] ?? '',
      quantity:data['quantity'] ?? '',


    );
  }

}
void SaveOrder(BuildContext context,String adresse,String  quantity,String  details,String  numero,String  idProduct,String  pric)async {
  final String IdOrder = Uuid().v4();
  String idUser = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance.collection("Orders")
      .doc(IdOrder)
      .set( Order_product(idOrder: IdOrder,idProduct: idProduct,idUser: idUser,adresse: adresse,numero: numero,pric: pric,details: details,quantity: quantity)
      .toJson());
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Product saved'),
      content: Text('The product has been saved successfully.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: navho(uid1: idUser,),
              ),
            );
            // Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );


}
Future<void> submit(BuildContext contex, GlobalKey<FormState> _formKey ,String adresse,String  quantity,String  details,String  numero,String  idProduct,String  pric ) async {

  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();


    // Upload image to Firebase Storage

    // Save product data to Firebase Firestore

    SaveOrder( contex,adresse,  quantity,  details,  numero,   idProduct, pric);

  }
}