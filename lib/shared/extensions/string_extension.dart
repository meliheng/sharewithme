extension StringX on String {
  String get toImage => 'assets/images/$this';
  String get toIcon => 'assets/icons/$this';
  String get toGif => 'assets/gifs/$this';
}
