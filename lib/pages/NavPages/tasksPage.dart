
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class tasksPage extends StatefulWidget {
  const tasksPage({Key? key}) : super(key: key);

  @override
  State<tasksPage> createState() => _tasksPageState();
}

class _tasksPageState extends State<tasksPage> {
  File? imageFile;
  void _ShowImageDialog(){
    showDialog(
      context: context,
      builder: (context)
      {
       return AlertDialog(
         title: Text('pleas chose an option'),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             InkWell(
               onTap: (){
               _getfromCamere();
               _getfromCamere();
               },
               child: Row(
                 children: [
                   Padding(
                       padding: EdgeInsets.all(4.0),
                     child: Icon(

                       Icons.camera,
                       color: Colors.amber,
                     ),

                   ),
                   Text('camera',
                   style: TextStyle(
                     color: Colors.amber

                   ),),

                 ],
                 
               ),
             ),
             InkWell(
               onTap: (){
                 _getfromCamere();
               },
               child: Row(
                 children: [
                   Padding(
                     padding: EdgeInsets.all(4.0),
                     child: Icon(

                       Icons.image,
                       color: Colors.amber,
                     ),

                   ),
                   Text('gellery',
                     style: TextStyle(
                         color: Colors.amber

                     ),),

                 ],

               ),
             )
           ],

         ),
       );
      }
    );
  }
  void  _getfromCamere()async{
    XFile? pickedFil=await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFil!.path);
    Navigator.pop(context);

  }
  void _cropImage(filePath)async
  {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,maxHeight: 1080,maxWidth: 1080);
    if (croppedImage !=null){
      setState(() {
      imageFile=File(croppedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child:
              GestureDetector(
                onTap: (){

                },
                child: IconButton(

                    onPressed: (){
                      _ShowImageDialog();
                    },
                    icon: Icon(Icons.person
                      ,
                      size:70,)
                ),
              ),
            ),
          ],

        ),
      )
    );
  }
}
