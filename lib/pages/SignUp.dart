import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jibley/Models/User.dart';
import 'package:jibley/pages/SignIn.dart';

import '../Services/authController.dart';
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  bool _obscureText = true;
  var emailController=TextEditingController();
  var paswwordController=TextEditingController();
  var usernam=TextEditingController();
void _handRegister(){
  if(usernam.text.isEmpty || usernam == null) {
    Get.snackbar("about User", "user messege",
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text('Account creation failed',
          style: TextStyle(

            color: Colors.black,
          ),
        ),
        messageText: Text('usernam is Empty' ,style: TextStyle(
            color: Colors.black
        ),
        )
    );
  }else{
    AuthController.instance.register(emailController.text , paswwordController.text,usernam.text);

  }

}
  late DatabaseReference dbref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbref=FirebaseDatabase.instance.ref().child('Users');

  }
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    List images =["fb.svg","skyp2.svg"
    ];
    return  GestureDetector(
      onTap:  () {
        // Unfocus the text field when the user taps outside of it.
        _focusNode.unfocus();
        _focusNode2.unfocus();
        _focusNode3.unfocus();
        emailController.selection=const TextSelection.collapsed(offset: 0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: w,
                  height: h*0.19,

                  decoration: const BoxDecoration(
                      image: DecorationImage(scale: 1,

                          image: AssetImage(
                            "assets/images/logo2.png" ,


                          ),
                          fit: BoxFit.none


                      )
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                height: h*0.6,
                width: w,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 10),

                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                ),

                child: Column(
                  children:  [

                    Center(child: Column(
                      children: [
                       /* Text("Hello"
                          , textAlign: TextAlign.center,

                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color:Colors.black87 ,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),*/
                        const Text("Creat Account"
                          , textAlign: TextAlign.center,

                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color:Colors.black87 ,
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                          height: 50,
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,

                              boxShadow:[
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 7,
                                    offset: Offset(1,1),
                                    color: Colors.orange.withOpacity(0.3)

                                )
                              ]
                          ),

                          child: TextField(
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            controller: usernam,
                            enableSuggestions: false,
                            focusNode: _focusNode,
                            autocorrect: false,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: "User Name",

                                prefixIcon: Icon(EvaIcons.person,color: Colors.orange[700]),
                                focusedBorder: const OutlineInputBorder(

                                    borderSide: BorderSide(
                                        color: Colors.black12,
                                        width:1.0
                                    )

                                ),
                                enabledBorder: const OutlineInputBorder(

                                    borderSide: BorderSide(

                                        color: Color(0xFFFDAD02),
                                        width: 1.0
                                    )

                                ),
                                border:const OutlineInputBorder(

                                )
                            ),
                          ),

                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10,left: 10,bottom:10,),
                          height: 50,
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,

                              boxShadow:[
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 7,
                                    offset: Offset(1,1),
                                    color: Colors.orange.withOpacity(0.3)

                                )
                              ]
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            controller: emailController,
                            focusNode: _focusNode2,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Email",

                                prefixIcon: Icon(EvaIcons.email,color: Colors.orange[700]),
                                focusedBorder: OutlineInputBorder(

                                    borderSide: const BorderSide(
                                        color: Colors.black12,
                                        width:1.0
                                    )

                                ),
                                enabledBorder: OutlineInputBorder(

                                    borderSide: const BorderSide(

                                        color: Color(0xFFFDAD02),
                                        width: 1.0
                                    )

                                ),
                                border:OutlineInputBorder(

                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5,right: 10,left: 10,bottom: 10),
                          height: 50,
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,

                              boxShadow:[
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 7,
                                    offset: Offset(1,1),
                                    color: Colors.orange.withOpacity(0.3)

                                )
                              ]
                          ),

                          child: TextField(
                            textInputAction: TextInputAction.go,
                            onSubmitted: (_) => _handRegister(),
                            controller: paswwordController,
                            obscureText: _obscureText,
                            enableSuggestions: false,
                            autofocus: false,
                            focusNode: _focusNode3,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Pasword",
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText ?Icons.visibility_off:Icons.visibility,color:Colors.orange[700] ,)
                                ),
                                prefixIcon: Icon(Icons.password_rounded,color: Colors.orange[700]),
                                focusedBorder: const OutlineInputBorder(

                                    borderSide: BorderSide(
                                        color: Colors.black12,
                                        width:1.0
                                    )

                                ),
                                enabledBorder: const OutlineInputBorder(

                                    borderSide: BorderSide(

                                        color: Color(0xFFFDAD02),
                                        width: 1.0
                                    )

                                ),
                                border:const OutlineInputBorder(

                                )
                            ),
                          ),

                        ),
                        const SizedBox(height: 5,),

                        GestureDetector(
                          onTap: (){

                            if(usernam.text.isEmpty || usernam == null) {
                              Get.snackbar("about User", "user messege",
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: Text('Account creation failed',
                                    style: TextStyle(

                                      color: Colors.black,
                                    ),
                                  ),
                                  messageText: Text('usernam is Empty' ,style: TextStyle(
                                      color: Colors.black
                                  ),
                                  )
                              );
                            }else{
                              AuthController.instance.register(emailController.text , paswwordController.text,usernam.text);

                              /*Map<String,String> Users={
                                'email':emailController.text,
                                'UserName':usernam.text,

                              };
                              dbref.push().set(Users);*/
                            }




                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                            height: 50,
                            width: w*0.5,

                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow:[
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: Offset(1,1),
                                      color: Colors.orange.withOpacity(0.3)

                                  )
                                ]
                            ),
                            child: const Center(child: Text("Register Now"
                              , textAlign: TextAlign.center,

                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color:Colors.white ,
                                  fontSize:20,
                                  fontWeight: FontWeight.w400
                              ),
                            ),),



                          ),
                        ),
                        const Text("Or Login using social Media"
                          , textAlign: TextAlign.center,

                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color:Colors.black87 ,
                              fontSize: 13,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        Container(
                          width: w,
                          height: 50,
                          child: Center(
                            child: Wrap(
                              children: List<Widget>.generate(2, (index) {
                                return Padding(
                                  padding: EdgeInsets.all(0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(


                                      "assets/images/"+images[index],
                                      height: 44,
                                      width: 10,
                                    ),
                                  ),
                                );
                              } ),

                            ),
                          ),
                        )
                      ],
                    ),),

                    SizedBox(height: 20,),


                  ],
                ),
              ),
            ),
            RichText(text:
            TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 15,

                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=> SignIn(),transition:Transition.leftToRightWithFade,duration: Duration(seconds: 1)),
                    text: " Login ",
                    style: TextStyle(

                        color: Colors.orange,
                        fontSize: 17,
                        decoration: TextDecoration.underline
                    ),


                  ),

                ]

            )
            ),
          ],
        ),

      ),
    );
  }
}
