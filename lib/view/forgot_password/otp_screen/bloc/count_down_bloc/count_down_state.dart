abstract class CountDownState {
  const CountDownState(this.duration);
  final int duration;
}

class CountDownStateInit extends CountDownState {
  const CountDownStateInit(super.duration);
}

class CountDownStateRun extends CountDownState {
  const CountDownStateRun(super.duration);
}

class CountDownStateComplete extends CountDownState {
  const CountDownStateComplete() : super(0);
}

class CountDownStateExpired extends CountDownState {
  const CountDownStateExpired() : super(0);
}
