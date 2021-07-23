import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'models/user.dart';

const String MESSAGES_COLLECTION = "messages";
const String TIMESTAMP_FIELD = "timestamp";
const String MESSAGE_TYPE_IMAGE = "image";

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
final UserId="";
Widget getImageLoader(){
  return
  Center(
    child: Image.asset(
      "assets/images/Loader.gif",
      height: 60,width: 60,
    ),
  );
}

Widget Loader() {
  return Center(
    child: SpinKitWave(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? kPrimaryColor : Color(0xFFB991EB),
          ),
        );
      },
      size: 30.0,
    ),
  );
}

Widget getButtonLoader(){
  return
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
            "assets/images/Loader.gif",
            height: 40,width: 40,
            color: Colors.white,
          ),

      ],
    );
}

class UniversalVariables {
  static final Color PrimaryColor = Color(0xFF6F35A5);
  static final Color blackColor = Color(0xff19191b);
  static final Color greyColor = Color(0xff8f8f8f);
  static final Color userCircleBackground = Color(0xff2b2b33);
  static final Color onlineDotColor = Color(0xff46dc64);
  static final Color lightBlueColor = Color(0xff0077d7);
  static final Color separatorColor = Color(0xff272c35);

  static final Color gradientColorStart = Color(0xff9D53E1);
  static final Color gradientColorEnd = Color(0xFF6F35A5);

  static final Color senderColor = Color(0xff8246B9);
  static final Color receiverColor = Color(0xffA35BE7);

  static final Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}

Future<void> handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  print(status);
}
String getImageName(String imageURLs){
  final startIndex = imageURLs.lastIndexOf('/');
  final endIndex = imageURLs.indexOf("?", startIndex);
  var imageName=imageURLs.substring(startIndex+1 , endIndex);
  return imageName;
}

Future<String> baseDirectroy()async{
  Directory baseDir ;
  if (Platform.isAndroid) {
    // baseDir = "/storage/emulated/0";
    baseDir = (await getApplicationDocumentsDirectory());
  } else {
  baseDir = (await getApplicationDocumentsDirectory());
  }
  String dirToBeCreated = "NatApp";
  String finalDir = baseDir.path + "/" + dirToBeCreated;
  //download2(dio,url,);
  var dir = Directory(finalDir);
  bool dirExists = await dir.exists();
  if (!dirExists) {
  dir.create(recursive: true)
  // The created directory is returned as a Future.
      .then((Directory directory) {
  print(directory.path);
  });
  //dir.create(); //pass recursive as true if directory is recursive
  }
  return finalDir;
}

Future<File> downloadImage(String imageURLs)async{
  //await ShareFile();
  final startIndex = imageURLs.lastIndexOf('/');
  final endIndex = imageURLs.indexOf("?", startIndex);
  var imageName=imageURLs.substring(startIndex+1 , endIndex);

  Directory baseDir ;
  if (Platform.isAndroid) {
    // baseDir = "/storage/emulated/0";
    baseDir = (await getApplicationDocumentsDirectory());
  } else {
    baseDir = (await getApplicationDocumentsDirectory());
  }
  String dirToBeCreated = "NatApp";
  String finalDir = baseDir.path + "/" + dirToBeCreated;
  //download2(dio,url,);
  var dir = Directory(finalDir);
  bool dirExists = await dir.exists();
  if (!dirExists) {
    dir.create(recursive: true)
    // The created directory is returned as a Future.
        .then((Directory directory) {
      print(directory.path);
    });
    //dir.create(); //pass recursive as true if directory is recursive
  }
  var finalPath=File(finalDir + '/$imageName'+".jpg");
  if(!finalPath.existsSync()){
    final ByteData imageData = await NetworkAssetBundle(Uri.parse(imageURLs)).load("");
    finalPath = await writeToFile(imageData,finalPath);
  }
  return finalPath;
}

Future<File> writeToFile(ByteData data,File finalPath) async {
  final buffer = data.buffer;
  return new File(finalPath.path).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

}

String nameFromEmail(String userEmail)
{
  var parts = userEmail.split('@');
  String prefix = parts[0].trim();
  return prefix;
}

Future<bool> callOnFcmApiSendPushNotifications(List <String> userToken, Users sender) async {

  final postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "registration_ids" : userToken,
    "collapse_key" : "type_a",
    "notification" : {
      "title": 'Calling...',
      "body" : sender.name,
    }
  };

  final datas ={
    "notification": {
      "title": 'Calling...',
      "body" : sender.name,
  },
  "data": {
  "title": "Awesome",
  "body": "Body",
  "click_action": "FLUTTER_NOTIFICATION_CLICK",
  "screen": "TOP10",
  "extradata": ""
  },
  "priority": "high",
  "registration_ids":userToken
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization': "key=AAAAd7gVKUg:APA91bHdBM6UR6YD-wFJoexbAvQ2Yy4sY8MVE8DNNi29Y3Qw1OMQZVmdUIYj1WT3YG3hH3HKNYxIejeY7ga_23JjcSQ8TnFF-Q4TgVG0hNP82GdmVqswK9fcpinnRXDej1pUlv8q1f5P" // 'key=YOUR_SERVER_KEY'
  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(datas),
      headers: headers);

  if (response.statusCode == 200) {
    // on success do sth
    print('test ok push CFM');
    return true;
  } else {
    print(' CFM error');
    // on failure do sth
    return false;
  }
}


