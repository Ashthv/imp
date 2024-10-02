abstract class FieldValidator<T> {
  final String errorText;
  FieldValidator(this.errorText);
  bool isValid(final T value);
  String? call(final T value) => isValid(value) ? null : errorText;
}

abstract class TextFieldValidator extends FieldValidator<String> {
  TextFieldValidator(super.errorText)
      : assert(errorText.isNotEmpty, "errorText can't be empty");

  bool get ignoreEmptyValues => true;

  @override
  String? call(final String value) =>
      (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);

  bool hasMatch(
    final String pattern,
    final String input, {
    final bool caseSensitive = true,
  }) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}
