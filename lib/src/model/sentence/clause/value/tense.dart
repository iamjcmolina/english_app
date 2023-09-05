enum Tense {
  simplePresent('Simple present'),
  simplePast('Simple past'),
  simpleFuture('Simple future'),
  simplePresentPerfect('Simple present perfect'),
  simplePastPerfect('Simple past perfect'),
  simpleFuturePerfect('Simple future perfect'),
  continuousPresent('Continuous present'),
  continuousPast('Continuous past'),
  continuousFuture('Continuous future'),
  continuousPresentPerfect('Continuous present perfect'),
  continuousPastPerfect('Continuous past perfect'),
  continuousFuturePerfect('Continuous future perfect');

  final String name;

  const Tense(this.name);
}
