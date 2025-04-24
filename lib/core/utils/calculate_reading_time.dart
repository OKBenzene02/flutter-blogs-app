int calculateReadingTime(String content) {
  final words = content.split(RegExp(r'\s+'));
  // Avg reading time of a human being = 200 - 300
  final readingTime = (words.length / 225);
  return readingTime.ceil();
}
