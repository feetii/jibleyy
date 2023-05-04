import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jibley/pages/NavPages/navho.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

import '../Models/Product.dart';
import '../Models/Order.dart';

class AddOrder extends StatefulWidget {
  final Product product;

  const AddOrder({Key? key,required this.product}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final _formKey = GlobalKey<FormState>();
  late String adresse, quantity, details,numero, idUser,pric;
  void SaveOrder(String adresse,String  quantity,String  details,String  numero,String  idProduct,String  pric)async {
    final String IdOrder = Uuid().v4();
    String idUser = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection("Orders")
        .doc(IdOrder)
        .set( Order_product(idOrder:IdOrder, idProduct: idProduct, idUser: idUser, adresse: adresse, quantity: quantity, details: details, numero: numero, pric: pric)
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
  Future<void> submit(   ) async {

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      // Upload image to Firebase Storage

      // Save product data to Firebase Firestore

      SaveOrder(adresse,  quantity,  details,  numero,  widget.product.id, pric);

    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

        title: Text('Add Order'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Adreese'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a adresse';
                  }
                  return null;
                },
                onSaved: (value) {
                  adresse = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numero'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Numero';
                  }
                  return null;
                },
                onSaved: (value) {
                  numero = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'details'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a details';
                  }
                  return null;
                },
                onSaved: (value) {
                 details= value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quntity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter a quntity';
                  }
                  return null;
                },
                onSaved: (value) {

                  quantity = (value!);
                  pric = int.parse(widget.product.discount) > 0
                      ? ((double.parse(widget.product.price) - (double.parse(widget.product.price) * int.parse(widget.product.discount) / 100)) * int.parse(quantity)).toStringAsFixed(2)
                      : (double.parse(widget.product.price) * int.parse(quantity)).toStringAsFixed(2);
                },
              ),


              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: submit,
                    child: Text('Submite'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
