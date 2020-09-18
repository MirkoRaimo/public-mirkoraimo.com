import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirkoraimo/apps/myDrawingApp/MyDrawingApp.dart';
import 'package:mirkoraimo/pages/counterRedux/counter_redux_main.dart';
import 'package:mirkoraimo/pages/foodMinimalUI/food_minimal_ui.dart';
import 'package:mirkoraimo/pages/partyGames/party_games_home.dart';
import 'package:mirkoraimo/pages/partyGames/pg_room_page.dart';
import 'package:mirkoraimo/pages/partyGames/pg_search_room.dart';
import 'package:mirkoraimo/pages/snakeGame/snake_game_main.dart';
import 'package:mirkoraimo/pages/tinderSwipeCards/tinder_swipe_cards_main.dart';
import 'package:mirkoraimo/providers/navigation_drawer_provider.dart';
import 'package:mirkoraimo/utilities/constants.dart';
import 'package:mirkoraimo/utilities/services.dart';
import 'package:mirkoraimo/utilities/size_config.dart';
import 'package:mirkoraimo/utilities/CommonColors.dart';
import 'package:provider/provider.dart';

import 'package:mirkoraimo/pages/youtubeClone/youtubeCloneMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _title = "mirkoraimo.com";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: PRIMARY_COLOR,
      ),
      home: ChangeNotifierProvider<NavigationDrawerProvider>(
          create: (context) => NavigationDrawerProvider(),
          child: MyHomePage(title: 'Welcome to mirkoraimo.com')),
      initialRoute: '/',
      routes: {
        HOME_ROUTE : (context) => MyHomePage(),
        FOOD_MINIMAL_UI_ROUTE : (context) => FoodMinimalUI(),
        YOUTUBE_CLONE : (context) => YoutubeClone(),
        DRAWING_APP : (context) => MyDrawingApp(),
        TINDER_SWIPE_CARDS : (context) => TinderSwipeCardsMain(),
        COUNTER_REDUX : (context) => CounterReduxMain(),
        SNAKE_GAME : (context) => SnakeGameMain(),
        PARTY_GAMES_HOME : (context) => PartyGamesHome(),
        PG_SEARCH_ROOM : (context) => PgSearchRoom(),
        PG_ROOM_PAGE : (context) => PgRoomPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {
  int _counter = 0;
  AnimationController controller;
  Animation<Offset> offset;
  NavigationDrawerProvider navigationDrawerProvider;

  @override
  void initState(){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    navigationDrawerProvider = Provider.of<NavigationDrawerProvider>(context);

    //bool _isLargeScreen = MediaQuery.of(context).size.width > 600 ? true : false;
    //double _welcomeWidth = MediaQuery.of(context).size.width / 100 * 6;
    //double _bodyLabelWidth = MediaQuery.of(context).size.width / 100 * 4;
    //double _madeLabelWidth = MediaQuery.of(context).size.width / 100 * 2;

    //return _isLargeScreen ? _homeLargeScreen(_welcomeWidth, _bodyLabelWidth, _madeLabelWidth) : _homeSmallScreen(_welcomeWidth, _bodyLabelWidth, _madeLabelWidth);
    //return Utilities.isLargeScreen(context) ? _homeLargeScreen(_welcomeWidth, _bodyLabelWidth, _madeLabelWidth) : _homeSmallScreen(_welcomeWidth, _bodyLabelWidth, _madeLabelWidth);
    //return _homeSmallScreen(_welcomeWidth, _bodyLabelWidth, _madeLabelWidth);
    return _homeScreen();
  }

  Widget _homeScreen (){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: customDrawer(),
      body: navigationDrawerProvider.getNavigationDrawerItem,
    );
  }

  Drawer customDrawer(){
    return Drawer(
      child: Column(
        children: <Widget>[
          (user != null && user.email != null)
              ?
          UserAccountsDrawerHeader(
              accountName: Text(user.displayName != null ? user.displayName : ""),
              currentAccountPicture: CircleAvatar(radius: 25, backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl) : Icon(Icons.person)),
              accountEmail: Text(user.email != null ? user.email : ""))
              :
          Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text("mirkoraimo.com", style: TextStyle(color: Colors.white),),
              onTap: () {
              },
            ),
          ),
          drawerListTile("Home", HOME_ROUTE),
          drawerListTile("Party Games", PARTY_GAMES_HOME),
        ],
      ),
    );
  }

  ListTile drawerListTile(String title, String route){
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: navigationDrawerProvider.currentNavigationDrawerItem == route ? FontWeight.bold : null),),
      onTap: () {
        Navigator.of(context).pop();
        navigationDrawerProvider.updateNavigationDrawerItem(route);
      },
    );
  }

}
