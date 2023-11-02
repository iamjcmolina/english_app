import '../../extensions/string_extension.dart';

class TextBuffer {
  final StringBuffer buffer = StringBuffer();

  TextBuffer add(String? string,
      {bool when = true, bool skipEndSpace = false}) {
    if (string != null && string.isNotEmpty && when) {
      buffer.write(skipEndSpace ? string : '$string ');
    }
    return this;
  }

  @override
  String toString() {
    String speech = buffer.toString();
    speech = speech.last() == ' ' ? speech.removeLast() : speech;
    return speech.first().toUpperCase() + speech.substring(1).toLowerCase();
  }
}
