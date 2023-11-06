enum Tense {
  simplePresent('S. Present'),
  simplePast('S. Past'),
  simpleFuture('S. Future'),
  simplePresentPerfect('S. Present Perfect'),
  simplePastPerfect('S. Past Perfect'),
  simpleFuturePerfect('S. Future Perfect'),
  continuousPresent('C. Present'),
  continuousPast('C. Past'),
  continuousFuture('C. Future'),
  continuousPresentPerfect('C. Present Perfect'),
  continuousPastPerfect('C. Past Perfect'),
  continuousFuturePerfect('C. Future Perfect');

  final String name;

  const Tense(this.name);
}
