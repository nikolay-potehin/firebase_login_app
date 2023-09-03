extension IntExtensions on int {
  String toCountString() => this < 100 ? toString() : '99+';
}
