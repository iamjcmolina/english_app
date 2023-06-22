class Speech {
  StringBuffer buffer = StringBuffer();

  void add(Object? partOfSpeech, {bool when = true, bool disablePrefixWhen = false}) {
    if (partOfSpeech == null || !when || partOfSpeech.toString().isEmpty) {
      return;
    }
    buffer.write(disablePrefixWhen? partOfSpeech : ' $partOfSpeech');
  }

  @override
  String toString() {
    return buffer.toString();
  }
}
