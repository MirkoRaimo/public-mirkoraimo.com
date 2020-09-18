import 'package:flutter/material.dart';
import 'package:mirkoraimo/apps/myDrawingApp/ui/widget/dialog_color_picker.dart';
import 'package:mirkoraimo/apps/myDrawingApp/utility/event.dart';


class MenuWidget extends StatefulWidget {
  MenuWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final colorAlert = ColorPickerAlert();
  final fillAlert = ColorPickerAlert();

  @override
  void initState() {
    super.initState();

    colorAlert.onSuccess = () {
      setState(() {});
      eventBus.fire(ChangeColorEvent(colorAlert.currentColor));
    };

    fillAlert.onSuccess = () {
      eventBus.fire(FillEvent(fillAlert.currentColor));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: essentialActions()
    );
  }

  List<Widget> essentialActions (){
    return <Widget>[
      IconButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).primaryColor,
        icon: new Icon(
          Icons.delete
        ),
        onPressed: () {
          eventBus.fire(ClearBoardEvent());
        },
      ),
      IconButton(
        color: Theme.of(context).primaryColor,
        icon: new Icon(
          Icons.palette,
        ),
        onPressed: () {
          colorAlert.show(context);
        },
      ),
      IconButton(
        color: Theme.of(context).primaryColor,
        icon: new Icon(
          Icons.undo
        ),
        onPressed: () {
          eventBus.fire(UndoEvent());
        },
      ),
      IconButton(
        color: Theme.of(context).primaryColor,
        icon: new Icon(
          Icons.redo,
        ),
        onPressed: () {
          eventBus.fire(RedoEvent());
        },
      ),
    ];
  }
}
