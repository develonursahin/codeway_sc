class Images {
  Images._();
  static Images? _instace;
  static Images get instance {
    if (_instace != null) return _instace!;
    _instace = Images._();
    return _instace!;
  }

  static const String _basePath = "assets/images/";
  String _joinPath(String filename) => '$_basePath$filename';
  String get splash => _joinPath("splash.png");

}
