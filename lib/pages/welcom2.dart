import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:jibley/pages/SignIn.dart';
import 'package:jibley/pages/SignUp.dart';
class WelcomPage2 extends StatefulWidget {
  const WelcomPage2({Key? key}) : super(key: key);

  @override
  State<WelcomPage2> createState() => _WelcomPage2State();
}


class _WelcomPage2State extends State<WelcomPage2> {
  @override
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

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        backgroundColor: Colors.orange,
        body: StreamBuilder<DocumentSnapshot>(
            stream: _userStream,
            builder: (context, snapshot1) {
              if (!snapshot1.hasData)
                return  CircularProgressIndicator();
              else{
                Map<String, dynamic> data = snapshot1.data!.data() as Map<
                    String,
                    dynamic>;

                return CupertinoApp(
                  debugShowCheckedModeBanner: false,

                  home: OnBoardingSlider(

                    finishButtonTextStyle: TextStyle(
                      fontSize: 16,
                      wordSpacing: 1,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),

                    finishButtonText: 'Register',

                    onFinish: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    hasFloatingButton: true,
                    hasSkip: true,
                    centerBackground: true,

                    finishButtonStyle: FinishButtonStyle(
                      splashColor: Colors.deepOrange,
                      hoverColor: Colors.deepOrange,

                      backgroundColor: Colors.black87,
                      elevation: 20
                    ),
                    skipTextButton: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    trailingFunction: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    controllerColor:Colors.black,
                    totalPage: 3,
                    headerBackgroundColor:  Color(0xFFFDAD02),
                    pageBackgroundColor: Color(0xFFFDAD02),
                    background: [
                      Image.asset(

                        "assets/images/" + images[0],
                        height:400,
                        width: 400,
                        fit: BoxFit.contain,



                      ),
                      Image.asset(
                        "assets/images/" + images[1],
                        height:400,
                        width: 400,
                        fit: BoxFit.none,
                      ),
                      Image.asset(
                        "assets/images/" + images[2],
                        height:400,
                        width: 400,
                        fit: BoxFit.none,
                      ),
                    ],
                    speed: 1.8,
                    pageBodies: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            SizedBox(
                              height: 250,
                            ),
                            Container(
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
                                  Text(
                                    data[trintro[0]]
                                    ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:Color(0xFFC03D02) ,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data[intros[0]],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            SizedBox(
                              height: 250,
                            ),
                            Container(
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
                                  Text(
                                    data[trintro[1]]
                                    ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:Color(0xFFC03D02) ,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data[intros[1]],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            SizedBox(
                              height: 250,
                            ),
                            Container(
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
                                  Text(
                                    data[trintro[2]]
                                    ,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:Color(0xFFC03D02) ,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data[intros[2]],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],

                  ),
                );
              }
            }
        ),


      ),
    );
  }
}
