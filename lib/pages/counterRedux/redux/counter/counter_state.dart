import 'package:flutter/widgets.dart';

@immutable
class CounterState{
  final int counter;
  final bool isChanging;

  CounterState({this.counter, this.isChanging});

  CounterState copyWith({int counter, bool isChanging}){
    return new CounterState(
        counter: counter ?? this.counter,
        isChanging: isChanging ?? this.isChanging
    );
  }

  factory CounterState.initial(){
    return new CounterState(counter: 0, isChanging: false);
  }
}

