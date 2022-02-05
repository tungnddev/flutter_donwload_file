class OSNotSupportException implements Exception {
  final String _os;
  OSNotSupportException(this._os);

  @override
  String toString() {
    return "This plugin not support for $_os";
  }
}