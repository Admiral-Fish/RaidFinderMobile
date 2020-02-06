class XoroShiro {
  List<int> _state = List<int>(2);

  XoroShiro(int seed) {
    _state[0] = seed;
    _state[1] = 0x82A2B175229D6A5B;
  }

  void setSeed(int seed) {
    _state[0] = seed;
    _state[1] = 0x82A2B175229D6A5B;
  }

  int _rotl(int x, int k, int mask) {
    var high = x << k;

    // The & mask is necessary given numbers in Dart are signed
    // It forces negative numbers to give the correct result
    // This is only necessary for right shifting
    var low = (x >> (64 - k)) & mask;

    return high | low;
  }

  int _next() {
    final s0 = _state[0];
    var s1 = _state[1];
    final result = s0 + s1;

    s1 ^= s0;
    _state[0] = _rotl(s0, 24, 0xffffff) ^ s1 ^ (s1 << 16);
    _state[1] = _rotl(s1, 37, 0x1fffffffff);

    return result;
  }

  int nextInt(int thresh, [int mask]) {
    if (mask == null) {
      return _next() & thresh;
    }

    var result = _next() & mask;

    while (result >= thresh) {
      result = _next() & mask;
    }

    return result;
  }
}
