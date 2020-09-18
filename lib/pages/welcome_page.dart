import 'package:flutter/material.dart';
import 'package:mirkoraimo/utilities/animations/FadeIn.dart';
import 'package:mirkoraimo/utilities/constants.dart';
import 'package:mirkoraimo/utilities/utilities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mirkoraimo/utilities/web/hover_extensions.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double _welcomeWidth = MediaQuery.of(context).size.width / 100 * 6;
    double _bodyLabelWidth = MediaQuery.of(context).size.width / 100 * 4;
    double _madeLabelWidth = MediaQuery.of(context).size.width / 100 * 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: Container()),
        _welcomeSentence(_welcomeWidth, context),
        SizedBox(height: MediaQuery.of(context).size.height/100 * 8,),
        FadeIn(
          2.0,
          Text(
            'This site is under construction.',
            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
                fontStyle: FontStyle.italic
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/100 * 3,),
        FadeIn(
          2.5,
          Text(
            'Meanwhile,',
            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 100 * 2,),
        FadeIn(3, Text("check out these examples!")),
        Flexible( //TODO: Insert here the new examples
          flex: 3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Utilities.mobilePresentationProject(context, 3, DRAWING_APP, AssetImage('assets/drawingApp/DrawingApp.png')),
              Utilities.mobilePresentationProject(context, 3, SNAKE_GAME, AssetImage('assets/snakeGame/Snake_Game.png')),
              Utilities.mobilePresentationProject(context, 3, YOUTUBE_CLONE, AssetImage('assets/youtubeClone/YoutubeClone.png')),
              Utilities.mobilePresentationProject(context, 3, TINDER_SWIPE_CARDS, AssetImage('assets/tinderSwipeCards/TinderSwipeCardsPreview.png')),
              Utilities.mobilePresentationProject(context, 3, COUNTER_REDUX, AssetImage('assets/counterRedux/CounterReduxPreview.png')),
              Utilities.mobilePresentationProject(context, 3, FOOD_MINIMAL_UI_ROUTE, AssetImage('assets/foodMinimalUI/FoodMinimalUIMenu.png')),
            ],
          ),
        ),
        Flexible(child: Container()),
        _bottomSentence(_madeLabelWidth),
      ],
    );
  }

  Padding _bottomSentence(double _madeLabelWidth) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _madeWithLoveWith(_madeLabelWidth),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _flutterAndFirebaseAndBrand(_madeLabelWidth),
              ],
            )
          ],
        ),
      );
  }

  FadeIn _welcomeSentence(double _welcomeWidth, BuildContext context) {
    return FadeIn(
        1.0, Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to ',
            style: TextStyle(
              fontSize: _welcomeWidth,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'mirkoraimo.com',
            style: TextStyle(
                fontSize: _welcomeWidth,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor
            ),
          ),
          Text(
            '!',
            style: TextStyle(
              fontSize: _welcomeWidth,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      );
  }

  Widget _madeWithLoveWith(double _madeLabelWidth){
    return Row(
      children: <Widget>[
        Text(
          'Made with ',
          style: TextStyle(
            fontSize: _madeLabelWidth,
            //fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Icon(Icons.favorite, semanticLabel: 'Love', color: Colors.red, size: _madeLabelWidth,),
        ),
        Text(
          ' with ',
          style: TextStyle(
            fontSize: _madeLabelWidth,
            //fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }

  Widget _flutterAndFirebaseAndBrand(double _madeLabelWidth){
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Image.asset(
            //'images/flutter_logo.png',
            'images/Flutter_svg.png',
            height: _madeLabelWidth + 10,
          ),
        ),
        Text(
          ' & ',
          style: TextStyle(
            fontSize: _madeLabelWidth,
            //fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Image.asset(
            //'images/flutter_logo.png',
            'images/Firebase_Logo_1200px.svg.png',
            height: _madeLabelWidth + 10,
          ),
        ),
        Text(
          ' by ',
          style: TextStyle(
            fontSize: _madeLabelWidth,
            //fontWeight: FontWeight.bold
          ),
        ),
        GestureDetector(
          child: Text(
            '@MirkoRaimo',
            style: TextStyle(
                fontSize: _madeLabelWidth,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor
              //fontWeight: FontWeight.bold
            ),
          ),
          onTap: () => _openStackOverflowPersonalAccount(),
        ).showCursorOnHover,
      ],
    );
  }

  _openStackOverflowPersonalAccount() async {
    const url = 'https://stackoverflow.com/users/10907417/mirko-raimo?tab=profile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
