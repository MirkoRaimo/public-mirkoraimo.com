import 'package:flutter/material.dart';
import 'package:mirkoraimo/providers/navigation_drawer_provider.dart';
import 'package:mirkoraimo/utilities/animations/FadeIn.dart';
import 'package:mirkoraimo/utilities/constants.dart';
import 'package:mirkoraimo/utilities/party_games_constants.dart';
import 'package:mirkoraimo/utilities/services.dart';
import 'package:mirkoraimo/utilities/utilities.dart';
import 'package:provider/provider.dart';

class PartyGamesHome extends StatefulWidget {
  @override
  _PartyGamesHomeState createState() => _PartyGamesHomeState();
}

class _PartyGamesHomeState extends State<PartyGamesHome> {
  @override
  Widget build(BuildContext context) {
    double _welcomeWidth = MediaQuery.of(context).size.width / 100 * 6;
    double _bodyLabelWidth = MediaQuery.of(context).size.width / 100 * 4;
    double _madeLabelWidth = MediaQuery.of(context).size.width / 100 * 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: Container()),
        FadeIn(1.0,Text(
            'Welcome to the',
            style: TextStyle(
              fontSize: _welcomeWidth,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FadeIn(
          1.0, Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'party game section',
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
        ),
        SizedBox(height: MediaQuery.of(context).size.height/100 * 8,),


        (user != null && user.email != null) ? _bodyUserSignedIn() : _bodyUserNotSignedIn(),
        Flexible(child: Container(),)
      ],
    );
  }

  Widget _bodyUserSignedIn(){
    return FadeIn(
      2.0,
      Column(
        children: <Widget>[
          Text(
            'Welcome, ${user.displayName}!',

            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor
            ),
          ),
          Text(
            'Do you want to play at \"${CAT_EATS_APPLES}\"?',
            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
                fontStyle: FontStyle.italic
              //fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 100 * 2,),
          Utilities.mobilePresentationProject(context, 1, PG_SEARCH_ROOM, AssetImage(CAT_EATS_APPLES_PATH_PNG), arguments: [CAT_EATS_APPLES, CAT_EATS_APPLES_PATH_PNG]),

        ],
      ),
    );
  }

  Widget _bodyUserNotSignedIn(){
    return FadeIn(
      2.0,
      Column(
        children: <Widget>[
          Text(
            'This section is under construction, stay tuned!',
            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
                fontStyle: FontStyle.italic
              //fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'Meanwhile, try to signin with your Google account!',
            style: TextStyle(
              //fontSize:  _bodyLabelWidth,
                fontStyle: FontStyle.italic
              //fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 8.0),
          _signInButton(),
        ],
      ),
    );
  }


  Widget _signInButton() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          signInWithGoogle().whenComplete(() {
            Provider.of<NavigationDrawerProvider>(context).notifyListeners();
            setState(() {});
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/signIn/google_logo.png"), height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Signin with Google',
                  style: TextStyle(
                    fontSize: 20,
                    //color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
