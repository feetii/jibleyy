import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Services/authController.dart';
import 'SignUp.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  var emailController=TextEditingController();
  var paswwordController=TextEditingController();

  bool _obscureText = true;
  void _handleLogin() {
    AuthController.instance.login(emailController.text, paswwordController.text);
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
                padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),

                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),

                child: Column(
                  children:  [

                    Center(child: Column(
                      children: [
                        Text("Hello"
                          , textAlign: TextAlign.center,

                          style: TextStyle(
                            fontFamily: 'Poppins',
                              color:Colors.black87 ,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("Sign into your Account"
                          , textAlign: TextAlign.center,

                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color:Colors.black87 ,
                              fontSize: 15,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 10,),
                          height: 50,
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                          child: TextField(
                            textInputAction: TextInputAction.next,

                            autofocus: false,
                            focusNode: _focusNode,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Email",

                                prefixIcon: Icon(EvaIcons.email,color: Colors.orange[700]),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.black12,
                                        width:1.0
                                    )

                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(

                                        color: Color(0xFFFDAD02),
                                        width: 1.0
                                    )

                                ),
                                border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                          height: 50,
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,
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

                          child: TextField(
                            textInputAction: TextInputAction.go,
                            onSubmitted: (_) => _handleLogin(),
                            controller: paswwordController,
                            obscureText: _obscureText,
                            enableSuggestions: false,
                            autofocus: false,
                            autocorrect: false,
                            focusNode: _focusNode2,
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
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.black12,
                                        width:1.0
                                    )

                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(

                                        color: Color(0xFFFDAD02),
                                        width: 1.0
                                    )

                                ),
                                border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)
                                )
                            ),
                          ),

                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(child: Container(),
                            ),
                            Text("Forgot your Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            AuthController.instance.login(emailController.text, paswwordController.text);
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
                            child: Center(child: Text("Login"
                              , textAlign: TextAlign.center,

                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color:Colors.black87 ,
                                  fontSize:20,
                                 fontWeight: FontWeight.w400
                              ),
                            ),),



                          ),
                        ),
                        SizedBox(height: 24,),
                        Text("Or Login using social Media"
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
                                     height: 40,
                                        width:5,
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
                text: "Don\'t have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 15,

                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>  SignUp(),transition:Transition.rightToLeftWithFade,duration: const Duration(seconds:1)),
                    text: " Register Now ",
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
