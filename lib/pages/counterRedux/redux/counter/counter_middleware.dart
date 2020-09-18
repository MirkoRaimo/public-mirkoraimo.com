import 'package:mirkoraimo/pages/counterRedux/redux/app/app_state.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_actions.dart';
import 'package:redux/redux.dart';

Middleware<AppState> createCounterMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    if (action is IncrementCounter){
      store.dispatch(ChangingCounterValue(isChanging: true)); //useless in sync methods

      store.dispatch(IncrementCounter);

      store.dispatch(ChangingCounterValue(isChanging: false)); //useless in sync methods
    }
    if (action is DecrementCounter){
      store.dispatch(DecrementCounter);
    }

    next(action);
  };
}