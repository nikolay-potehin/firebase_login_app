extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isWhitespace() => trim().isEmpty;

  bool isValidDouble() => double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  String capitalize() {
    if (isWhitespace()) return this;

    if (length < 2) return toUpperCase();

    return substring(0, 1).toUpperCase() + substring(1, length);
  }
}
