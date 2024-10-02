class ProfileViewModel {
  List<String> profileListKey = [];

  void saveProfileKey(final String key) {
    if (!profileListKey.contains(key)) {
      profileListKey.add(key);
    }
  }

  String getProfileKey(final int index) => profileListKey[index];

  void deleteProfileKey(final String value) {
    profileListKey.remove(value);
  }

  List<String> getAllProfileKeys() => profileListKey;

  void clearProfileKeys() {
    profileListKey.clear();
  }
}
