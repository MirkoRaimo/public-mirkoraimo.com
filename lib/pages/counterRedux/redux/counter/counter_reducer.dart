
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_actions.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_state.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<CounterState>([
  TypedReducer<CounterState, IncrementCounter>(_incrementing),
  TypedReducer<CounterState, DecrementCounter>(_decrementing),
  TypedReducer<CounterState, ChangingCounterValue>(_changingValue) //useless if it is called in a sync method
]);

CounterState _incrementing(CounterState state, IncrementCounter action) {
  return state.copyWith(counter: state.counter + 1);
}

CounterState _changingValue(CounterState state, ChangingCounterValue action){
  return state.copyWith(isChanging: action.isChanging);
}

CounterState _decrementing(CounterState state, DecrementCounter action) {
  return state.copyWith(counter: state.counter - 1);
}