import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_middleware.dart';
import 'package:redux/redux.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';

Store<AppState> createStore() {
  return Store(
      appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..add(createCounterMiddleware())
  );
}