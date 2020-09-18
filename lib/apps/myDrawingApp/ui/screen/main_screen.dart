import 'package:flutter/material.dart';
import 'package:mirkoraimo/apps/myDrawingApp/ui/widget/board_widget.dart';
import 'package:mirkoraimo/apps/myDrawingApp/ui/widget/menu_widget.dart';

class DrawingMainScreen extends StatefulWidget {
  DrawingMainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DrawingMainScreenState createState() => _DrawingMainScreenState();
}

class _DrawingMainScreenState extends State<DrawingMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BoardWdiget(),
            Positioned(
              bottom: 0,
              right: 12,
              child: MenuWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
