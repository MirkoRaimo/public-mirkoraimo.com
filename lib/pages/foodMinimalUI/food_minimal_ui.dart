import 'package:flutter/material.dart';
import 'package:mirkoraimo/utilities/size_config.dart';
import 'package:mirkoraimo/utilities/utilities.dart';

import 'details_page.dart';

class FoodMinimalUI extends StatefulWidget {
  @override
  _FoodMinimalUIState createState() => _FoodMinimalUIState();
}

class _FoodMinimalUIState extends State<FoodMinimalUI> {
  //SizeConfig sizeConfig = new SizeConfig();

  @override
  Widget build(BuildContext context) {
    //sizeConfig.init(context);
    if (SizeConfig.safeBlockVertical == null) {
      SizeConfig.init(context);
    }

    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: _buildBody(context),
    );
  }

  ListView _buildBody(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        _buildTopBar(context),
        SizedBox(height: SizeConfig.safeBlockVertical * 4),
        _buildTitle(),
        SizedBox(height: SizeConfig.safeBlockVertical * 6),
        _buildMainList(context)
      ],
    );
  }

  Container _buildMainList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          SizeConfig.safeBlockVertical * 27.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.safeBlockVertical * 11)),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        primary: false,
        padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 6.5,
            right: SizeConfig.safeBlockHorizontal * 5),
        children: <Widget>[
          _buildFoodItem(
              'assets/foodMinimalUI/plate1.png', 'Salmon bowl', '\$24.00'),
          _buildFoodItem(
              'assets/foodMinimalUI/plate2.png', 'Spring bowl', '\$22.00'),
          _buildFoodItem(
              'assets/foodMinimalUI/plate6.png', 'Avocado bowl', '\$26.00'),
          _buildFoodItem(
              'assets/foodMinimalUI/plate5.png', 'Berry bowl', '\$24.00'),
          SizedBox(height: SizeConfig.safeBlockVertical * 6),
          _buildBottomButtons(),
          _buildCredits(context),
        ],
      ),
    );
  }

  Padding _buildCredits(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Based on ',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 2,
              //fontWeight: FontWeight.bold
            ),
          ),
          GestureDetector(
            child: Text(
              '@RonDesignLab',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockVertical * 2,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor
                  //fontWeight: FontWeight.bold
                  ),
            ),
            onTap: () => Utilities.launcUrl(
                "https://dribbble.com/shots/6687016-Foody-Food-by-Subscription"),
          ),
          Text(
            ' & ',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 2,
              //fontWeight: FontWeight.bold
            ),
          ),
          GestureDetector(
            child: Text(
              '@RajaYogan',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockVertical * 2,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor
                  //fontWeight: FontWeight.bold
                  ),
            ),
            onTap: () => Utilities.launcUrl(
                "https://www.youtube.com/watch?v=K1uH_SN4X0w"),
          ),
        ],
      ),
    );
  }

  Row _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: SizeConfig.safeBlockVertical * 9.5,
          width: SizeConfig.safeBlockHorizontal * 15.5,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: SizeConfig.safeBlockVertical * 0.25),
            borderRadius:
                BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.5),
          ),
          child: Center(
            child: Icon(Icons.search, color: Colors.black),
          ),
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 9.5,
          width: SizeConfig.safeBlockHorizontal * 15.5,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: SizeConfig.safeBlockVertical * 0.25),
            borderRadius:
                BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.5),
          ),
          child: Center(
            child: Icon(Icons.shopping_basket, color: Colors.black),
          ),
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 9.5,
          width: SizeConfig.safeBlockHorizontal * 31,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: SizeConfig.safeBlockVertical * 0.25),
              borderRadius:
                  BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2.5),
              color: Color(0xFF1C1428)),
          child: Center(
              child: Text('Checkout',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockVertical * 2))),
        )
      ],
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 11),
      child: Row(
        children: <Widget>[
          Text('Healthy',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockVertical * 3.5)),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 2.5),
          Text('Food',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockVertical * 3.5))
        ],
      ),
    );
  }

  Padding _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 4,
          left: SizeConfig.safeBlockHorizontal * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {},
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 2.5,
            right: SizeConfig.safeBlockHorizontal * 2.5,
            top: SizeConfig.safeBlockVertical * 1),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                      heroTag: imgPath, foodName: foodName, foodPrice: price)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                        height: SizeConfig.safeBlockHorizontal * 19.5 < 100
                            ? SizeConfig.safeBlockHorizontal * 19.5
                            : 100,
                        width: SizeConfig.safeBlockHorizontal * 19.5 < 100
                            ? SizeConfig.safeBlockHorizontal * 19.5
                            : 100,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 2.5),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.safeBlockVertical * 2.5,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.safeBlockVertical * 2,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }
}
