import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
class Product {

  final String image, title, catygorie, description, id;
  final String price,discount;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.discount,
    required this.description,
    required this.catygorie,


  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        image = map['image'],
        title = map['title'],
        price = map['price'],
        discount = map['discount'],
        description = map['description'],
        catygorie = map['catygorie'];



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'price': price,
      'discount': discount,
      'description': description,
      'catygorie': catygorie,

    };
  }
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toString(),
      discount: (data['discount'] ?? 0.0).toString(),
      catygorie: data['catygorie'] ?? '',
      image:data['image'] ?? '',


    );
  }
}
void SaveProduct(String image,String title,String description,String catygorie,String price,String discount,List<String> likedBy)async {
  final String Id = Uuid().v4();
    await FirebaseFirestore.instance.collection("Foods").doc("Burgers").collection("collectionPath")
        .doc(Id)
        .set(Product(image: image,id: Id,title: title,description: description,price: price,discount: discount,catygorie: catygorie ,).toJson()).then((_) {

  });
  Product product =Product(image: image,id: Id,title: title,description: description,price: price,discount: discount,catygorie: catygorie,);
}
// Method to like a product

