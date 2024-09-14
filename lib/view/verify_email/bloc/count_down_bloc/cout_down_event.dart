abstract class CountDownEvent {
  const CountDownEvent();
}

class CountDownEventInit extends CountDownEvent {
  const CountDownEventInit({required this.duration});
  final int duration;
}

class CountDownEventStart extends CountDownEvent {
  const CountDownEventStart({required this.duration});
  final int duration;
}

class CountDownEventTick extends CountDownEvent {
  const CountDownEventTick({required this.duration});
  final int duration;
}

class CountDownEventExpired extends CountDownEvent {}
