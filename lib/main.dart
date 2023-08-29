import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jibley/pages/SplashScreen.dart';
import 'package:jibley/pages/welcome_page.dart';


import 'Services/authController.dart';
import 'Services/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://hsqbwzavrkyvacrlthoy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhzcWJ3emF2cmt5dmFjcmx0aG95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA2NjgyNzcsImV4cCI6MjAwNjI0NDI3N30.IaTWriGvHq29LHJfrIOtZvuXrthyqAMbhpmptQhf2UE',
  );
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: SplashScreen(),
    );
  }
}



