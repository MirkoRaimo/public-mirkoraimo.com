import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mirkoraimo/utilities/utilities.dart';

class TopBarIconButton extends StatelessWidget {
  double _spaceBetweenIcons;
  String _snackBarSentence;
  Icon _icon;
  String _networkImage = '';

  TopBarIconButton(this._spaceBetweenIcons, this._snackBarSentence, this._icon,
      {Key key})
      : super(key: key);

  TopBarIconButton.network(
      this._spaceBetweenIcons, this._snackBarSentence, this._networkImage,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*TODO: change Image.network with FadeInImage (requires an image as placeholder) or with cached_network_image (requires community package)*/
    return IconButton(
        //icon: _networkImage.isEmpty ? _icon : ClipOval(child: CachedNetworkImage(imageUrl: _networkImage, placeholder: (context, url) => CircularProgressIndicator(),),),
        //CachedNetworkImage(imageUrl: _networkImage, placeholder: (context, url) => CircularProgressIndicator(),),
        icon: _networkImage.isEmpty
            ?
        _icon
            :
        Image.network(_networkImage, fit: BoxFit.fill,
          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        padding: EdgeInsets.symmetric(horizontal: _spaceBetweenIcons),
        onPressed: () {
          onPressedTopBarButton(_snackBarSentence, context);
        });
  }
}

void onPressedTopBarButton(String _snackBarSentence, BuildContext context) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 500),
    content: Text(_snackBarSentence),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
