import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:natapp/components/rounded_button.dart';
import 'package:natapp/models/user.dart';
import 'package:natapp/provider/ImageUploadProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../main.dart';
import 'ImagePicker.dart';

class UserProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }

}

class UserProfileState extends State<UserProfile>{
  String userEmail,userId,name,userImage;
  @override
  void initState() {
    userEmail = prefs.getString("UserEmail");
    userId = prefs.getString("UserId");
    var parts = userEmail.split('@');
    var prefix = parts[0].trim();
    name = prefix.replaceAll(new RegExp(r'[^A-Za-z]'),'');
    // TODO: implement initState
    super.initState();
  }


  File selectedImage;
  void _selectedImage(File image){
    selectedImage=image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xffB1097C),
                    kPrimaryColor,
                  ]),
            )),
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (ctx,userSnapshot){
          if(userSnapshot.connectionState==ConnectionState.waiting)
          {
            return Loader();
          }
          else{
            var user=userSnapshot.data;
            return ListView(
              padding: EdgeInsets.all(15),
              children: [
                ImagePickers(_selectedImage,user["profile"],selectedImage),
                SizedBox(height: 20,),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Color(0xFFF5F6F9),
                  elevation: 4,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.person_alt,color: kPrimaryColor,),
                          SizedBox(width: 10,),
                          Text(user["name"],style: TextStyle(fontSize: 16))
                        ],
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Color(0xFFF5F6F9),
                  elevation: 4,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.envelope,color: kPrimaryColor,),
                          SizedBox(width: 10,),
                          Text(user["email"],style: TextStyle(fontSize: 16))
                        ],
                      )),
                ),
                SizedBox(height: 10,),
                (isLoading)?LoadingButton():RoundedButton(
                  text: "Update Profile",
                  press: () async{
                    if(selectedImage!=null&&selectedImage!="")
                    uploadImageToFirebase(context);
                  },
                ),
              ],
            );
          }
        },
      )
    );
  }

  bool isLoading=false;
  Future uploadImageToFirebase(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    await Provider.of<ImageUploadProvider>(context,listen: false).uploadUserProfile(context,userId,selectedImage).
    then((value) => setState(() {
      isLoading=false;
    }));

  }
}