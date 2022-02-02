class InvalidRouteException implements Exception {
  final String message;

  InvalidRouteException(this.message);

  @override
  String toString() {
    return message;
  }
}
