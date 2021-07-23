import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

import '../../../constants.dart';
import 'cached_image.dart';
import 'package:http/http.dart' as http;

class chatImageView extends StatelessWidget {
  final String imageURL;
  final String title;
  final String tage;

  chatImageView(this.imageURL, this.title, this.tage);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
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
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Share.shareFiles([imageURL],
                    subject: 'File Share',
                    text: 'Hello, check I have share Proect Documentfile!');
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Hero(
        tag: tage,
        child: Center(
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained,
              imageProvider: FileImage(File(imageURL)),
            )
        ),
      ),
    );
  }
}
