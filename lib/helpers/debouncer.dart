import 'dart:async';

class Debouncer<T>{
  
  final Duration duration;
  void Function(T value)? onValue;
  T? _value;
  Timer? _timer;

  Debouncer({
    required this.duration,
    this.onValue
  });

  T get value => _value!;

  set value(T val){
    this._value= val;
    this._timer?.cancel();
    this._timer= Timer(duration,()=>onValue!(this._value!));
  }
}