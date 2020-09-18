import 'package:flutter/material.dart';
import 'package:mirkoraimo/pages/partyGames/party_games_home.dart';
import 'package:mirkoraimo/pages/welcome_page.dart';
import 'package:mirkoraimo/utilities/constants.dart';

class NavigationDrawerProvider with ChangeNotifier {
  String currentNavigationDrawerItem = HOME_ROUTE;

  Widget get getNavigationDrawerItem {
    switch (currentNavigationDrawerItem){
      case WELCOME_ROUTE:
        return WelcomePage();
      case PARTY_GAMES_HOME:
        return PartyGamesHome();
      default:
        return WelcomePage();

    }
  }

  void updateNavigationDrawerItem(String navigation) {
    currentNavigationDrawerItem = navigation;
    notifyListeners();
  }

}