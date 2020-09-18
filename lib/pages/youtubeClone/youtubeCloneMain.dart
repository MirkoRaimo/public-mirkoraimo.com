
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirkoraimo/pages/youtubeClone/home_page.dart';
import 'package:mirkoraimo/pages/youtubeClone/subscription_page.dart';
import 'package:mirkoraimo/pages/youtubeClone/trending_page.dart';
import 'activity_page.dart';
import 'library_page.dart';
import 'models/top_bar_icon_button.dart';

/*void main() {
  var _items = List<String>.generate(10000, (i) => "Item $i");

  runApp(MyApp(
    items: _items,
    tabPages: [HomePage(_items), TrendingPage(), SubscriptionPage(), ActivityPage(), LibraryPage()],
  ));
}*/

class YoutubeClone extends StatefulWidget {
  List<String> items;
  List tabPages;
  Widget _currentPage;
  int _currentTabIndex;

  YoutubeClone({Key key, @required this.items, this.tabPages}) : super(key: key){
    items = List<String>.generate(10000, (i) => "Item $i");
    tabPages = [HomePage(items), TrendingPage(), SubscriptionPage(), ActivityPage(), LibraryPage()];
    _currentPage = tabPages[0];
    _currentTabIndex = 0;
  }

  @override
  _YoutubeCloneState createState() => _YoutubeCloneState();
}

class _YoutubeCloneState extends State<YoutubeClone> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: widget._currentPage,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() {
    final double _spaceBetweenIcons = 0.0;
    return AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 120,
              //child: CachedNetworkImage(imageUrl: 'https://www.guffantiformaggi.com/wp-content/uploads/2017/09/youtube.png', placeholder: (context, url) => CircularProgressIndicator(),),
              child:
              Image.network("https://www.guffantiformaggi.com/wp-content/uploads/2017/09/youtube.png",
                fit: BoxFit.fill,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

            ),
            Expanded(
              child: Column(),
            ),
            //TopBarIconButton(_spaceBetweenIcons, '\'Chromecast\' button', Icon(Icons.cast, color: Colors.black)),
            TopBarIconButton(_spaceBetweenIcons, '\'Upload video\' button', Icon(Icons.videocam, color: Colors.black)),
            TopBarIconButton(_spaceBetweenIcons, '\'Search\' button', Icon(Icons.search, color: Colors.black)),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: _spaceBetweenIcons),
//              child: Icon(Icons.cast, color: Colors.black),
//            ),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: _spaceBetweenIcons),
//              child: Icon(Icons.videocam, color: Colors.black),
//            ),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: _spaceBetweenIcons),
//              child: IconButton(icon: Icon(Icons.search, color: Colors.black),
//                  onPressed: (){
//                      final snackBar = SnackBar(
//                        content: Text('This is your account'),
//                      );
//                      Scaffold.of(context).showSnackBar(snackBar);
//
//                  })
//            ),

            Container(
              height: 50,
              width: 50,
              child: ClipOval(child: TopBarIconButton.network(_spaceBetweenIcons, '\'Avatar\' button', 'https://slimdigital.com.au/wp-content/uploads/2016/02/cute-kitten.jpg')),

            ),


            //TopBarIconButton.network(_spaceBetweenIcons, '\'Avatar\' button', 'https://slimdigital.com.au/wp-content/uploads/2016/02/cute-kitten.jpg'),

//            Padding(
//                padding: EdgeInsets.symmetric(horizontal: _spaceBetweenIcons),
//                child: Container(
//                  height: 50,
//                  width: 50,
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      image: DecorationImage(
//                          image: NetworkImage(
//                              'https://slimdigital.com.au/wp-content/uploads/2016/02/cute-kitten.jpg'))),
//                  // child: Image.network('https://slimdigital.com.au/wp-content/uploads/2016/02/cute-kitten.jpg')
//                )),


          ],
        ));
  }

  BottomNavigationBar _bottomNavigationBar() {


    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget._currentTabIndex,
        onTap: (i) {
          setState(() {
            widget._currentTabIndex = i;
            widget._currentPage = widget.tabPages[i];
          });
        },
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), title: Text('Subscriptions')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text('Activity')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.folder), title: Text('Library'))
        ]);
  }
}
