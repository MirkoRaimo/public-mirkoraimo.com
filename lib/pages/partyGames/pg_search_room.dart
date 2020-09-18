import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirkoraimo/utilities/constants.dart';
import 'package:mirkoraimo/utilities/party_games_constants.dart';
import 'package:mirkoraimo/utilities/services.dart';

class PgSearchRoom extends StatefulWidget {
  @override
  _PgSearchRoomState createState() => _PgSearchRoomState();
}

class _PgSearchRoomState extends State<PgSearchRoom> {
  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();
  CollectionReference dbSearchRoomCollection;
  List<Object> _arguments;
  String gameName;
  String gameImagePath;

  @override
  Widget build(BuildContext context) {
    _arguments = ModalRoute.of(context).settings.arguments;
    gameName = _arguments[0];
    gameImagePath = _arguments[1];
    dbSearchRoomCollection = Firestore.instance
        .collection(DB_PARTY_GAMES_COLLECTION)
        .document(DB_ROOMS)
        .collection(DB_ROOM_PATH[gameName]);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: _handleBody(context),
        floatingActionButton:
          FloatingActionButton(
              heroTag: "Create a new room",
              child: Icon(Icons.add) ,
              onPressed: (){
                _showCreateRoomDialog();
              },
          ),
      ),
    );
  }

  Widget _handleBody(BuildContext context){
    return StreamBuilder(
      stream: dbSearchRoomCollection.snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor)));
        }else{
          List<DocumentSnapshot> roomsFound = snapshot.data.documents;
          //roomsFound.sort((a, b) => a.data[FILE_DB_DOC_TYPE_ID].toString().compareTo(b.data[FILE_DB_DOC_TYPE_ID].toString()));

          //return roomsFound != null && !roomsFound.isEmpty ? _hasDocuments(context, roomsFound, singleCollabModel) : Center(child: Text("Non sono presenti documenti personali"),);
          return roomsFound != null && roomsFound.isNotEmpty ? _roomsFound(context, roomsFound) : Center(child: Text("No rooms found.\nThe db works, but I have to complete this section hahaha"),);
        }
      },
    );
  }

  Widget _roomsFound(BuildContext context, List<DocumentSnapshot> roomsFound ){
    const double titleFontSize = 24.0;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SelectableText("Rooms found for the game \"",),
              SelectableText(gameName, style: TextStyle(color: Theme.of(context).primaryColor),),
              SelectableText("\"",),
            ],
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            itemCount: roomsFound.length,
            separatorBuilder: (context, int index) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey,width: 1.0),
                      ),
                    ),
                  ),
                ),
            itemBuilder: (context, listIndex){
              String roomName = roomsFound[listIndex].data[DB_ELEMENT_ROOM_NAME].toString();
              return ListTile(
                title: SelectableText(roomName),
                onTap: (){
                  _showEnterRoomDialog(roomName);
                },
              );
            }
        ),
      ],
    );
  }

  void _showCreateRoomDialog() {
    TextEditingController roomNameController = new TextEditingController();
    TextEditingController passwordNameController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: new Text("Create a new room!"),
              content: Form(
                key: _dialogFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) => value.isEmpty ? 'Rooms like to have names!' : null,
                      controller: roomNameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          labelText: "Gorgeous Room Name",
                        ),
                    ),
                    SizedBox (height: 16.0,),
                    TextFormField(
                      validator: (value) => value.isEmpty ? 'Rooms love passwords!' : null,
                      controller: passwordNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        labelText: "Secret Password",
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Create"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    validateAndSave();
                    createRoom(roomNameController.text, passwordNameController.text);
                  },
                ),
                FlatButton(
                  child: Text("Close", style: TextStyle(color: Colors.black54),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEnterRoomDialog(String roomName) {
    //TextEditingController roomNameController = new TextEditingController();
    TextEditingController passwordNameController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: new Text("Enter the secret of " + roomName),
              content: Form(
                key: _dialogFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) => value.isEmpty ? 'Rooms love passwords!' : null, //TODO VERIFICARE CON LA PWD DELLA STANZA
                      controller: passwordNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        labelText: "Secret Password",
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Join!"),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    validateAndSave();
                    //createRoom(roomNameController.text, passwordNameController.text);
                    Navigator.pushNamed(context, PG_ROOM_PAGE, arguments: [gameName, roomName, CAT_EATS_APPLES_PATH_PNG]);
                  },
                ),
                FlatButton(
                  child: Text("Close", style: TextStyle(color: Colors.black54),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void createRoom(String roomName, String roomPassword) {
    dbSearchRoomCollection
        .document(roomName)
        .setData({
      DB_ELEMENT_ROOM_NAME: roomName,
      DB_ELEMENT_ROOM_PASSWORD: roomPassword,
      DB_ELEMENT_USER_OWNER: user.email,
      //DB_ELEMENT_USERS: {user.email : user.displayName},
      DB_ELEMENT_USERS: [user.displayName],
      DB_ELEMENT_DT_INS: DateTime.now().millisecondsSinceEpoch,
    });
  }

  void addUserToRoom(String roomName){
    dbSearchRoomCollection.document(roomName).updateData({
      DB_ELEMENT_USERS: FieldValue.arrayUnion([user.email])
    });
  }

  void validateAndSave() {
    final FormState form = _dialogFormKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      Navigator.of(context).pop();
    } else {
      print('Form is invalid');
    }
  }
}
