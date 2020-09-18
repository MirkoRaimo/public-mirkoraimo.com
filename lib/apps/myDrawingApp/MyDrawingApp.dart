import 'package:flutter/material.dart';

import 'package:mirkoraimo/apps/myDrawingApp/const.dart';
import 'package:mirkoraimo/apps/myDrawingApp/ui/screen/main_screen.dart';

class MyDrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawingMainScreen(title: 'Paint');
  }
}