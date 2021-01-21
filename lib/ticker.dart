class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream<int>.periodic(
            const Duration(seconds: 1), (x) => ticks - x % (ticks + 1))
        .asBroadcastStream();
  }
}
