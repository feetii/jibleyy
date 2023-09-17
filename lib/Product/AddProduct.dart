import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jibley/Models/Product.dart';
import 'package:jibley/Product/supabase.dart';
import 'package:jibley/pages/NavPages/HomePage.dart';
import 'package:jibley/pages/NavPages/navho.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';


class AddProductForm extends StatefulWidget {
  String? uid1;
   AddProductForm({Key? key, required uid1}) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  late String catigory;
  late String price;
  late String discount;

  File? _imageFilee;

  /*void  _getfromGellery()async{
    XFile? pickedFil=await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFil!.path);
    Navigator.pop(context);

  }*/

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {

      setState(() {
        _imageFilee = File(pickedFile.path);
      });
    }
  }
  void SaveProduct(String image,String title,String description,String catygorie,String price,)async {
    final String Id = Uuid().v4();


    await FirebaseFirestore.instance.collection("Foods")
        .doc(Id)
        .set(Product(image: image,id: Id,title: title,description: description,price: price,discount: discount,catygorie: catygorie)
        .toJson());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product saved'),
        content: const Text('The product has been saved successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: navho(uid1: widget.uid1,),
                ),
              );
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    Product product =Product(image: image,id: Id,title: title,description: description,price: price,discount: discount,catygorie: catygorie,);
  }
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      // Upload image to Firebase Storage
      final storageRef =
      FirebaseStorage.instance.ref().child('products').child(_name);
      final uploadTask = storageRef.putFile(_imageFilee!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Get image URL from Firebase Storage
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Save product data to Firebase Firestore

     SaveProduct(imageUrl, _name, _description, catigory, price);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(

        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'catigorie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a catigorie';
                  }
                  return null;
                },
                onSaved: (value) {
                 catigory= value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'pric'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter a pric';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = (value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'dISCOUNT'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter a pric';
                  }
                  return null;
                },
                onSaved: (value) {
                  discount = (value!);
                },
              ),
              const SizedBox(height: 16),
              _imageFilee != null
                  ? Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Image.file(_imageFilee!))
                  : Text('No image selected'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the DestinationPage when the button is pressed.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => supabase()),
                      );
                    },
                    child: Text('go'),
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