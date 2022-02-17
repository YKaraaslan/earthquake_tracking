class Assets {
  static final String world = _path('world', 'jpg');
  static final String bang = _path('bang', 'png');
  static final String depth = _path('depth', 'png');
  static final String city = _path('city', 'png');
}

String _path(String name, String type) {
  return 'assets/images/' + name + '.' + type;
}