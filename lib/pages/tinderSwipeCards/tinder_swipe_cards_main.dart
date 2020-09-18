import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Tinder Swipe Cards',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: ExampleHomePage(),
//    );
//  }
//}

class TinderSwipeCardsMain extends StatefulWidget {
  @override
  _TinderSwipeCardsMainState createState() => _TinderSwipeCardsMainState();
}

class _TinderSwipeCardsMainState extends State<TinderSwipeCardsMain>
    with TickerProviderStateMixin {
  List<Card> listOfCards = _generateListOfCards();

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    //listOfCards = _generateListOfCards();

    return new Scaffold(
      appBar: AppBar(
        title: SelectableText("Flutter Tinder Swipe Cards"),
      ),
      body: _buildBody(context, controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refreshList(),
        tooltip: 'Change color',
        child: Icon(Icons.palette),
      ),
    );
  }

  Column _buildBody(BuildContext context, CardController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
      ),
      SelectableText(
        "Flutter Tinder Swipe Cards",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
      ),
      _buildCustomCards(context, controller),
    ]);
  }

  Container _buildCustomCards(BuildContext context, CardController controller) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        //width: Utilities.isLargeScreen(context) ? MediaQuery.of(context).size.width * 0.6 : double.infinity,
        //width:  MediaQuery.of(context).size.width * 0.6,
        child: Builder(builder: (BuildContext innerContext) {
          return TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: listOfCards.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) {
              return listOfCards[index];
            },
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping

              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              // Get orientation & index of swiped card!
              if (orientation != CardSwipeOrientation.RECOVER) {
                String snackBarMessage = "";
                switch (orientation) {
                  case CardSwipeOrientation.LEFT:
                    snackBarMessage = "Left!";
                    break;
                  case CardSwipeOrientation.UP:
                    snackBarMessage = "Up!";
                    break;
                  case CardSwipeOrientation.RIGHT:
                    snackBarMessage = "Right!";
                    break;
                  case CardSwipeOrientation.DOWN:
                    snackBarMessage = "Down!";
                    break;
                  case CardSwipeOrientation.RECOVER:
                    break;
                }
                Scaffold.of(innerContext).showSnackBar(SnackBar(
                  content: Text(
                    snackBarMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  duration: Duration(milliseconds: 500),
                  backgroundColor: listOfCards[index].color,
                ));
              }
            },
          );
        }));
  }

  void _refreshList() {
    setState(() {
      listOfCards = _generateListOfCards();
    });
  }

  static List<Card> _generateListOfCards({int dim}) {
    dim ??= 100;
    List<Card> listOfCards = [];
    for (int i = 0; i < dim ?? 100; i++) {
      Card card = new Card(
          color: Colors.primaries[Random().nextInt(Colors.accents.length)],
          child: Center(
              child: Text(
            'Card number $i',
            //style: Theme.of(context).textTheme.headline5,
          )));
      listOfCards.add(card);
    }

    return listOfCards;
  }
}
