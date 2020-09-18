import 'package:flutter/widgets.dart';
import 'package:mirkoraimo/pages/counterRedux/redux/counter/counter_state.dart';

@immutable
class AppState {
  final CounterState counterState;

  AppState({
    this.counterState
  });

  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
    );
  }
}