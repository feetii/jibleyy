

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Models/User.dart';
import 'SignIn.dart';

class welcomPage extends StatefulWidget {
  const welcomPage({Key? key}) : super(key: key);

  @override
  State<welcomPage> createState() => _welcomPageState();
}

class _welcomPageState extends State<welcomPage> {
  late Stream<DocumentSnapshot> _userStream;
  late Stream<DocumentSnapshot> _userStream2;

  bool isLoading = true;
 CollectionReference _reference=FirebaseFirestore.instance.collection('intros');
@override



  List intros =[
    "intro1",
    "intro2",
    "intro3",
  ];

  List images =[
    "food6.jpg",
    "food1.jpg",
    "food3.jpg",
  ];
  List trintro =[
    "trintro1",
    "trintro2",
    "trintro3",
  ];
  void initState() {
    // TODO: implement initState
    super.initState();

    _userStream = FirebaseFirestore.instance.collection('intro').doc('intros').snapshots();
    _userStream2 = FirebaseFirestore.instance.collection('intro').doc('titre_Desintro').snapshots();
  }

  @override
  void fetch()async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("User2").get();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: (context, snapshot1) {
          if (!snapshot1.hasData)
            return  CircularProgressIndicator();
          else {
            Map<String, dynamic> data = snapshot1.data!.data() as Map<
                String,
                dynamic>;

            return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (_, index) {
                          return Container(

                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Color(0xFFFDAD02),

                                image: DecorationImage(scale: 1,
                                    image:
                                    AssetImage(

                                      "assets/images/" + images[index],


                                    ),
                                    fit: BoxFit.none

                                )
                            ),

                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap:()=>Get.to(()=>SignIn()) ,
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.deepOrange,
                                        ),
                                        width: 100,

                                        margin: EdgeInsets.only(top:70,left: 30),
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            SvgPicture.asset(
                                              'assets/images/iconNext.svg',
                                              height: 25,
                                              width: 40,
                                              color: Colors.white,
                                            ),
                                            SvgPicture.asset(
                                                  'assets/images/iconNext.svg',
                                              height: 30,
                                              width: 35,
                                              color: Colors.white,
                                              ),
                                          ],
                                        )


                                      ),
                                    ),
                                  ],
                                )
                                ,
                                SizedBox(height: 300),

                                Center(
                                  child: Container(
                                    height: 280,
                                    width: 290,
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.all(20),

                                    alignment: Alignment.bottomLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white
                                    ),

                                    child: Column(
                                      children: [
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(3, (indexDotes) {
                                          return Container(
                                            margin: EdgeInsets.only(top: 5,bottom: 20,left:2 ),
                                            width: index==indexDotes?25:8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: index==indexDotes?Colors.red:Colors.black87,
                                            ),
                                          );
                                        })

                                        ,
                                      ),
                                        Center(child: Text(
                                          data[trintro[index]]
                                          , textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:Color(0xFFC03D02) ,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),


                                        ),
                                        SizedBox(height: 20,),
                                        Center(child: Text(data[intros[index]]
                                          , textAlign: TextAlign.center,
                                          style: TextStyle(

                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),


                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ]
            );
          }
        }
    )
     );
        }
}
