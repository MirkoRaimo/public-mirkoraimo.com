import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import 'package:mirkoraimo/utilities/web/translate_on_hover.dart';

extension HoverExtensions on Widget {
  // Get a regerence to the body of the view
  //static final appContainer = html.window.document.getElementById('app-container');
  static final appContainer = html.window.document.querySelectorAll('flt-glass-pane')[0];

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      // When the mouse enters the widget set the cursor to pointer
      onHover: (event) {
        appContainer.style.cursor = 'pointer';
      },
      // When it exits set it back to default
      onExit: (event) {
        appContainer.style.cursor = 'default';
      },
    );
  }

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}