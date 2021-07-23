import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:natapp/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color ,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: (text=="SIGN UP")?
        LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffF47CCF),
              Color(0xFFB585F1),
            ]) :LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffDA2FA5),
              Color(0xFF9354CF),
            ]),
      ),
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child:TextButton(
        style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            )
        ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const LoadingButton({
    Key key,
    this.text,
    this.press,
    this.color ,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: (text=="SIGN UP")?
        LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffF47CCF),
              Color(0xFFB585F1),
            ]) :LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffDA2FA5),
              Color(0xFF9354CF),
            ]),
      ),
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child:SpinKitWave(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.white : Colors.white70,
            ),
          );
        },
        size: 20.0,
      ),
    );
  }
}
