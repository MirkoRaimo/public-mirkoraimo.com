import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirkoraimo/utilities/party_games_constants.dart';

class PgRoomPage extends StatefulWidget {
  @override
  _PgRoomPageState createState() => _PgRoomPageState();
}

class _PgRoomPageState extends State<PgRoomPage> {
  DocumentReference dbCurrentRoomReference;
  List<Object> _arguments;
  String gameName;
  String roomName;
  String gameImagePath;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    gameName = _arguments[0];
    roomName = _arguments[1];
    gameImagePath = _arguments[2];

    dbCurrentRoomReference = Firestore.instance
        .collection(DB_PARTY_GAMES_COLLECTION)
        .document(DB_ROOMS)
        .collection(DB_ROOM_PATH[gameName])
        .document(roomName);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Welcome to the room called: " + roomName, style: TextStyle(fontSize: 16.0),),
              Text("The current participants are:"),
              StreamBuilder(
                stream: dbCurrentRoomReference.snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor)));
                  }else{
                    DocumentSnapshot roomData = snapshot.data;
                    //roomsFound.sort((a, b) => a.data[FILE_DB_DOC_TYPE_ID].toString().compareTo(b.data[FILE_DB_DOC_TYPE_ID].toString()));

                    //return roomsFound != null && !roomsFound.isEmpty ? _hasDocuments(context, roomsFound, singleCollabModel) : Center(child: Text("Non sono presenti documenti personali"),);
                    return roomData != null ? _roomDataFound(context, roomData) : Center(child: Text("No data found, sorry! :("),);
                  }
                },
              ),
              _startGameButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roomDataFound(BuildContext context, DocumentSnapshot roomData){
    List<String> users = new List<String>.from(roomData.data[DB_ELEMENT_USERS]);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, int index){
          return ListTile(
            title: Text(users[index]),
          );
        }
    );
  }

  Widget _startGameButton() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Start game!',
            style: TextStyle(
              fontSize: 20,
              //color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
