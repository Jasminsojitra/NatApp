import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natapp/models/user.dart';

import '../../../constants.dart';

class chatUserView extends StatefulWidget {
  final Users receiver;

  chatUserView(this.receiver);

  @override
  _chatUserViewState createState() => _chatUserViewState();
}

class _chatUserViewState extends State<chatUserView> {
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffB1097C),
              kPrimaryColor,
            ]),
      ),
      child: SafeArea(
          bottom: false,
          child: Scaffold(
              body: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffB1097C),
                        kPrimaryColor,
                      ]),
                ),
                child: FlexibleSpaceBar(
                    title: Text(widget.receiver.name,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    background: (widget.receiver.profilePhoto == "")
                        ? Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.fitHeight,
                          )
                        : Image.network(
                            widget.receiver.profilePhoto,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
                SliverToBoxAdapter(
              child: Container(
                color: Color(0xFFF5F6F9),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 2,
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:const EdgeInsets.all(15.0),
                              child: Text(
                                "About and email",
                                style: TextStyle(fontSize: 16,color: kPrimaryColor),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                                child: Text("Hy there, I am using NatApp",
                                  style: TextStyle(fontSize: 16,color: Colors.black87),
                                )
                            ),
                            Divider(
                              color: Colors.grey[200],
                            ),
                            Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(widget.receiver.email,
                                    style: TextStyle(fontSize: 16),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                                child: Text("Email",
                                  style: TextStyle(fontSize: 14,color: Colors.grey[400]),
                                )
                            ),
                          ]
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 8, 15, 0),
                            child: Row(
                              children: [
                                Text("Mute notification",
                                    style: TextStyle(fontSize: 16)),
                                Spacer(),
                                (Platform.isAndroid)
                                    ? Switch(
                                        value: isNotification,
                                        onChanged: (bool val) {
                                          setState(() {
                                            isNotification = val;
                                          });
                                        },
                                      )
                                    : CupertinoSwitch(
                                        value: true,
                                        onChanged: (bool val) {
                                          setState(() {
                                            isNotification = val;
                                          });
                                        },
                                      )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[200],
                          ),

                          Padding(
                            padding:const EdgeInsets.all(15.0),
                            child: Text(
                              "Custom notification",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),

                          Divider(
                            color: Colors.grey[200],
                          ),

                          Padding(
                            padding:const EdgeInsets.all(15.0),
                            child: Text(
                              "Media Visibility",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text("Disappearing messeges",
                                style: TextStyle(fontSize: 16)),
                            subtitle: Text("Off",
                              style: TextStyle(fontSize: 14,color: Colors.grey[400]),
                            ),
                            trailing: Icon(Icons.timelapse_rounded,color: kPrimaryColor,),
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          ),

                          Divider(
                            color: Colors.grey[200],
                          ),

                          ListTile(
                            title: Text("Encryption",
                                style: TextStyle(fontSize: 16)),
                            subtitle: Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text("Messages and call are end-to-end encrypted. Tap to verify.",
                              style: TextStyle(fontSize: 14,color: Colors.grey[400]),
                            ),),
                            trailing: Icon(Icons.lock,color: kPrimaryColor,),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 2,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.block_outlined,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Block",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.redAccent))
                            ],
                          )),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 2,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_down_rounded,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Report contact",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.redAccent))
                            ],
                          )),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            )
          ]))),
    );
  }
}
