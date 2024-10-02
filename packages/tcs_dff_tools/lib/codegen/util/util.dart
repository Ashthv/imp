extension StringExtention on String {
  String toSnakeCase() {
    var result = '';
    for (var i = 0; i < length; i++) {
      if (this[i].toUpperCase() == this[i] && i > 0) {
        result += '_${this[i].toLowerCase()}';
      } else {
        result += this[i].toLowerCase();
      }
    }
    return result;
  }
}
