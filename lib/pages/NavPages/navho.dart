import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jibley/pages/NavPages/cartPage.dart';
import 'package:jibley/pages/NavPages/tasksPage.dart';

import '../../Services/authController.dart';
import '../AddProduct.dart';
import 'HomePage.dart';

class navho extends StatefulWidget {
 String? uid1;
   navho({Key? key ,required this.uid1}) : super(key: key);

  @override
  State<navho> createState() => _navhoState();
}

class _navhoState extends State<navho> {
  int _currentIndex =0;


  setCurrentIndex(int index)
  {setState(() {
    _currentIndex=index;
  });

  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(



        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.amber,
          height:55,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.shopping_cart, size: 30),
            Icon(Icons.add_task_rounded, size: 30),

          ],
          onTap: (index)=>setCurrentIndex(index),
        ),
        body: [

          homePage(uid1: widget.uid1,),
          cartPage(),
          AddProductForm(uid1:widget.uid1 ,)
        ] [_currentIndex],

      ),
    );
  }
}
