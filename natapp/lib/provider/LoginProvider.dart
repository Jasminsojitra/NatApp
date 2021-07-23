import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natapp/Screens/Home/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../main.dart';

class LoginProvider with ChangeNotifier {


  Future<bool> getData(BuildContext contexts,String email,String password,String deviceTokens) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    bool isLogin=false;
    String Uid,Created;
    try{
      final User user=await auth.currentUser;
      final UserCredential _authenticatedUser = await auth.signInWithEmailAndPassword(email: email, password: password);
      if(user!=null){
        if (user.emailVerified) {
          print("true");
          Uid=user.uid;
          FirebaseFirestore.instance.collection('users').doc(Uid).update({
            "token":deviceTokens
          }).then((result){//pop dialog
            print("result");
          });
          prefs.setBool("IsLogin", true);
          prefs.setString("UserEmail", email);
          prefs.setString("UserId", Uid);
          prefs.setString("created", Created.toString());
          // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
          // firebaseMessaging.subscribeToTopic(nameFromEmail(email.trim()));
          return true;
        }
        else {
          //pop dialog
          Fluttertoast.showToast(
              msg: "Please verify email first",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        return false;
      }
      else{
        Fluttertoast.showToast(
            msg: "Something went wrong, Try again letter",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
    }catch(ex){
      Fluttertoast.showToast(
          msg: "Email Id or password is wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }
  }
}