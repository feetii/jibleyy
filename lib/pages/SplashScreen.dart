
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';


import '../Services/authController.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FlutterSplashScreen.gif(
      gifPath: 'assets/images/example.gif',
      gifWidth: 269,
      gifHeight: 474,

      duration: const Duration(milliseconds: 4000),
      onInit: () async {

        await Future.delayed(const Duration(milliseconds:3000));

      },
      onEnd: () async {
        AuthController.instance.init();
      }, defaultNextScreen: null,

    );
 /*   return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),

    );*/


  }
}
