import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_actions.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_state.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/store.dart';
import 'package:redux/redux.dart';

import 'redux/app/app_state.dart';

//class CounterReduxMain extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter app with Redux'),
//    );
//  }
//}

class CounterReduxMain extends StatefulWidget {
  //CounterReduxMain({Key key, this.title}) : super(key: key);
  CounterReduxMain({Key key}) : super(key: key);
  final String title = 'Flutter app with Redux';

  @override
  _CounterReduxMainState createState() => _CounterReduxMainState();
}

class _CounterReduxMainState extends State<CounterReduxMain> {
  final Store<AppState> store = createStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          title: SelectableText(widget.title),
        ),
        body: _body(context),
        floatingActionButton: _rowFab(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Center _body(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _welcomeSentence(context),

            Padding(padding: EdgeInsets.all(8),),
            SelectableText.rich(
              TextSpan(
                children:[
                  TextSpan(text: 'You have pushed the button this many times:'),
                ]
              ),

            ),
            StoreConnector<AppState, CounterState>(
                converter: (store) => store.state.counterState,
                builder: (BuildContext context, CounterState counterState){
                  bool isChanging = counterState.isChanging;
                  int counter = counterState.counter;

                  return isChanging ?
                  Center(
                      child: CircularProgressIndicator()
                  )
                      :
                    SelectableText(
                    counter.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
            )

          ],
        ),
      );
  }

  Padding _welcomeSentence(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "This is an example of an app built using the "),
                        TextSpan(text: "REDUX ", style: Theme.of(context).textTheme.headline4),
                        TextSpan(text: "state management!"),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
  }

  Row _rowFab() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(padding: EdgeInsets.all(8),),
          FloatingActionButton(
              heroTag: "btnReduxDecrement",
            onPressed: () => store.dispatch(DecrementCounter()),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          Padding(padding: EdgeInsets.all(8),),
          FloatingActionButton(
            heroTag: "btnReduxIncrement",
            onPressed: () => store.dispatch(IncrementCounter()),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      );
  }
}
