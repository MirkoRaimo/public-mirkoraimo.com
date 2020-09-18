import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mirkoraimo/utilities/utilities.dart';


class HomePage extends StatelessWidget{
  HomePage (List<String> this.items);

  final List<String> items;

  var list = [
    'https://o.aolcdn.com/images/dims?quality=85&image_uri=https%3A%2F%2Fo.aolcdn.com%2Fimages%2Fdims%3Fcrop%3D1280%252C719%252C0%252C0%26quality%3D85%26format%3Djpg%26resize%3D1600%252C900%26image_uri%3Dhttps%253A%252F%252Fs.yimg.com%252Fos%252Fcreatr-uploaded-images%252F2018-12%252F230f6990-fe0e-11e8-b36e-c04614e37356%26client%3Da1acac3e1b3290917d92%26signature%3D8e4e26338acf197ca96c6b62ddeca707f1dc5b37&client=amp-blogside-v2&signature=2452ea5a346830e81bcf4c102c101cb55036a48b',
    'https://i.ytimg.com/vi/FlsCjmMhFmw/maxresdefault.jpg',
    'https://i.ytimg.com/vi/_GuOjXYl5ew/maxresdefault.jpg'
  ];


  Widget build(BuildContext context) {
      return Utilities.isLargeScreen(context) ? _largeScreen(context) : _smallScreen();
  }

  Widget _largeScreen (BuildContext context){
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridCalculateCrossAxisCount(context)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                //height: 200.0,
                //child: CachedNetworkImage(imageUrl: list[index % 3], placeholder: (context, url) => CircularProgressIndicator(),)
                child: Image.network(list[index % 3],fit: BoxFit.fill,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            _videoInfo()
          ],
        );
      },
    );
  }

  Widget _smallScreen (){
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                //height: 200.0,
                child: //CachedNetworkImage(imageUrl: list[index % 3], placeholder: (context, url) => CircularProgressIndicator(),)
                Image.network(list[index % 3]),
              ),
            ),
            _videoInfo()
          ],
        );
      },
    );
  }

  int gridCalculateCrossAxisCount(BuildContext context){
    return (MediaQuery.of(context).size.width / 300).round();
  }

  Widget _videoInfo() {
//    var list = [
//      'https://www.guffantiformaggi.com/wp-content/uploads/2017/09/youtube.png',
//      'https://www.guffantiformaggi.com/wp-content/uploads/2017/09/youtube.png',
//      'https://www.guffantiformaggi.com/wp-content/uploads/2017/09/youtube.png'
//    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              height: 50,
              width: 50,
              child:  //CachedNetworkImage(imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png', placeholder: (context, url) => CircularProgressIndicator(),)),
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      //'This is the title of the video, and I would like to have a very long title',
                      'This is the title of the video.\nWow, this title is really really long!',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text('The coolest channel\n' +
                        '2000 views' +
                        ' - ' +
                        '3 hours ago'),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.more_vert)
        ],
      ),
    );
  }
}