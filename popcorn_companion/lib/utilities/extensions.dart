extension StringExtensions on String {
  String stripHtml() {
    // ignore: unnecessary_this
    return this.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), "");
  }
}

extension DateTimeExtensions on DateTime {
  String convertToString() => "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
}
