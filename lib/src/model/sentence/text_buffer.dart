import '../../util/util.dart';

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
    speech = Util.last(speech) == ' ' ? Util.lessLast(speech) : speech;
    return speech.substring(0, 1).toUpperCase() +
        speech.substring(1).toLowerCase();
  }
}
