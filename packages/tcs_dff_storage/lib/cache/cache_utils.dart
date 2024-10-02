Duration getExpiryDate({required final Duration duration}) {
  var currentTime = DateTime.now();
  currentTime = currentTime.add(duration);
  return Duration(milliseconds: currentTime.millisecondsSinceEpoch);
}

enum Policy {
  cacheFirst,
  cacheOnly,
  networkOnly,
}
