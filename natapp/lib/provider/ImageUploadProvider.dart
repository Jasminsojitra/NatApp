import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;
  ViewState get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }

  Future<bool> uploadUserProfile(BuildContext context,String userId, File selectedImage)async{
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("images/$userId.jpeg")
        .putFile(selectedImage);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        "profile":downloadUrl
      }).then((result){
        prefs.setString("profileImage", downloadUrl);

      }).catchError((onError){
        final snackBar =
        SnackBar(content: Text('Opps! Something went wrong'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      });
      final snackBar =
      SnackBar(content: Text('Image uploaded succesfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {

      print(
          'Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }
  }

}

enum ViewState{

  IDLE,
  LOADING,

}
