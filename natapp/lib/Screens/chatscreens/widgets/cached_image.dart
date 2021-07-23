  import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';

import '../../../constants.dart';

  class CachedImage extends StatefulWidget
  {
    final String imageUrl;
    final bool isRound;
    final double radius;
    final double height;
    final double width;

    final BoxFit fit;

    final String noImageAvailable =
        "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";
    CachedImage(
        this.imageUrl, {
          this.isRound = false,
          this.radius = 0,
          this.height,
          this.width,
          this.fit = BoxFit.cover,
        });

  @override
  State<StatefulWidget> createState() {
    return CachedImageState();
  }
  }
  class CachedImageState extends State<CachedImage> {

    File imagePath=null;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncDownloadImage(widget.imageUrl);
  }
    void asyncDownloadImage(String imageUrls)async{
      imagePath= await downloadImage(imageUrls);
      if(imagePath!=null) {
        setState(() {});
      }
    }
    @override
    Widget build(BuildContext context) {
      try {
        return SizedBox(
          height: widget.isRound ? widget.radius : widget.height,
          width: widget.isRound ? widget.radius : widget.width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.isRound ? 50 : widget.radius),
              child: (imagePath==null)
                  ?ClipRRect(
                  child:Image.asset("assets/images/blur.jpeg",height: (widget.height==null)?widget.height:300,width: 200,fit: BoxFit.cover,))
                  :ClipRRect(
                  child:Image.file(imagePath,height: (widget.height==null)?widget.height:300,width: 200,fit: BoxFit.cover,)),

              // CachedNetworkImage(
              //   imageUrl: imageUrl,
              //   fit: fit,
              //   placeholder: (context, url) =>
              //       ClipRRect(
              //         child:Image.asset("assets/images/blur.jpeg",height: (height==null)?height:300,width: 200,fit: BoxFit.cover,)),
              //   errorWidget: (context, url, error) =>
              //       Image.network(noImageAvailable, fit: BoxFit.cover),
              // )
          ),
        );
      } catch (e) {
        print(e);
        return Image.network(widget.noImageAvailable, fit: BoxFit.cover);
      }
    }
  }
