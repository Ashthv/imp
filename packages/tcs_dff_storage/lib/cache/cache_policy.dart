import 'cache_utils.dart';

class CachePolicy {
  final String storageKey;
  final Duration? expiry;
  final Policy policy;
  const CachePolicy({
    required this.storageKey,
    this.expiry,
    this.policy = Policy.networkOnly,
  });
}
