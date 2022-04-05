import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:relis/arguments/photoArguments.dart';
import 'package:relis/authentication/user.dart';

class ShowPhoto extends StatefulWidget {
  static const routeName = '/ShowPhotoPage';
  @override
  _ShowPhotoState createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  bool widgetVisible = true;
  @override
  Widget build(BuildContext context) {
    dynamic pageData = ModalRoute.of(context)!.settings.arguments as PhotoArguments;
    return Hero(
      tag: "profilePhoto",
      child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widgetVisible ? AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 28,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(pageData.pageTitle,
          style: TextStyle(color: Colors.white,),
        ),//Text('Preview'),
        elevation: 0.0,
        // shadowColor: Colors.black,
        backgroundColor: Colors.black.withOpacity(0.5), //Color(0xff164040),
      ) : null,
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          constrained: true,
          panEnabled: true,
          clipBehavior: Clip.none,
          minScale: 0.5,
          alignPanAxis: false,
          onInteractionStart: (details){
            setState(() {
              widgetVisible = false;
            });
          },
          onInteractionEnd: (details){
            setState(() {
              widgetVisible = true;
            });
          },
          boundaryMargin: EdgeInsets.all(double.infinity),
          maxScale: 5.0,
          child: Image(
            image: pageData.photoURL != null && pageData.photoURL != "" ? Image.network(pageData.photoURL).image
            // NetworkImage(pageData.photoURL)
                : Image.asset("ReLis.gif").image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
    );
  }
}