import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natapp/Screens/Home/HomePage.dart';
import 'package:natapp/Screens/Login/components/background.dart';
import 'package:natapp/Screens/Signup/signup_screen.dart';
import 'package:natapp/components/already_have_an_account_acheck.dart';
import 'package:natapp/components/rounded_button.dart';
import 'package:natapp/components/rounded_input_field.dart';
import 'package:natapp/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:natapp/provider/LoginProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/text_field_container.dart';
import '../../../constants.dart';
import '../../../provider/UserProvider.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Body();
  }

}


class _Body extends State<Body> {

  bool isLoading=false;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController= TextEditingController();
  TextEditingController pwdInputController= TextEditingController();
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(value=="")
      return 'Please Enter Email';
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }
  @override
  void dispose() {
    emailInputController.clear();
    pwdInputController.clear();
    super.dispose();
  }
  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be more than 6 characters';
    } else {
      return null;
    }
  }
  @override
  void initState() {
    super.initState();
    _getToken();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  String deviceTokens="";
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  _getToken()async{
    await firebaseMessaging.getToken().then((deviceToken){
      print("deviceToken : $deviceToken ");
      deviceTokens=deviceToken;
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: getImageLoader(),
        );
      },
    );
  }

  bool isVisible=false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
        key: _registerFormKey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              inputController: emailInputController,
              hintText: "Your Email",
              validation: emailValidator,
              focusNode:focusNode,
            ),
            TextFieldContainer(
              child:
              TextFormField(
                controller: pwdInputController,
                obscureText: !isVisible,
                validator: pwdValidator,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: (isVisible)?
                  GestureDetector(
                    child: Icon(
                      Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onTap: (){
                      setState(() {
                        isVisible=!isVisible;
                      });
                    },
                  ):
                  GestureDetector(
                    child: Icon(
                      Icons.visibility,
                      color: kPrimaryColor,
                    ),
                    onTap: (){
                      setState(() {
                        isVisible=!isVisible;
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            (isLoading)?LoadingButton():
            RoundedButton(
              text: "LOGIN",
              press: () async{
                if (_registerFormKey.currentState.validate()) {
                  //_onLoading();
                  setState(() {
                    isLoading=true;
                  });
                  try{
                    var respo=await Provider.of<LoginProvider>(context,listen: false).getData(context, emailInputController.text, pwdInputController.text, deviceTokens);
                    print(respo);
                    if(respo){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => HomePage()), (
                          route) => false);
                      setState(() {
                        isLoading=false;
                      });
                    }
                    else{
                      setState(() {
                        isLoading=false;
                      });
                    }
                  }catch(ex){
                    print(ex);
                    setState(() {
                      isLoading=false;
                    });
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    )
    );
  }
}
