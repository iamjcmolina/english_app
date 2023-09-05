class SentenceBuffer {
  StringBuffer buffer = StringBuffer();

  void add(Object? partOfSpeech, {bool when = true, bool disablePrefixWhen = false}) {
    if (partOfSpeech == null || !when || partOfSpeech.toString().isEmpty) {
      return;
    }
    buffer.write(disablePrefixWhen? partOfSpeech : ' $partOfSpeech');
  }

  @override
  String toString() {
    String speech = buffer.toString();
    return speech.substring(0,1).toUpperCase() + speech.substring(1).toLowerCase();
  }
}
