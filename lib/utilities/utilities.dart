import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mirkoraimo/utilities/web/hover_extensions.dart';
import 'animations/FadeIn.dart';

class Utilities {
  static launcUrl(String url) async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  @deprecated
  static Widget imageWebCircularProgressIndicator (String url, {BoxFit fit}){
    return Stack(
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        Image.network(url, fit: fit,),
      ],
    );
  }

  static bool isLargeScreen (BuildContext context){
    return MediaQuery.of(context).size.width > 600 ? true : false;
  }

  static Widget mobilePresentationProject(BuildContext context, double delayFadeIn, String namedRoot, ImageProvider projectImage, {List<Object> arguments}){
    //double _sizeUIExample =  MediaQuery.of(context).size.width / 1.5;
    double _sizeUIExample =  250.0;
    return FadeIn(delayFadeIn,
      SizedBox(height: _sizeUIExample,
        child: new AspectRatio(
          aspectRatio: 1 / 1,
          child: GestureDetector(
            onTap: () => arguments != null ? Navigator.pushNamed(context, namedRoot, arguments: arguments) : Navigator.pushNamed(context, namedRoot),
            child: Stack(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                          image: projectImage
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).showCursorOnHover.moveUpOnHover;
  }
}