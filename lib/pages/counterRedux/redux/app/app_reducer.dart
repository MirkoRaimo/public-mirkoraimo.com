import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_reducer.dart';

import './app_state.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    counterState: counterReducer(state.counterState,action),
  );
}