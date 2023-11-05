enum Tense {
  simplePresent('S. present'),
  simplePast('S. past'),
  simpleFuture('S. future'),
  simplePresentPerfect('S. present perfect'),
  simplePastPerfect('S. past perfect'),
  simpleFuturePerfect('S. future perfect'),
  continuousPresent('C. present'),
  continuousPast('C. past'),
  continuousFuture('C. future'),
  continuousPresentPerfect('C. present perfect'),
  continuousPastPerfect('C. past perfect'),
  continuousFuturePerfect('C. future perfect');

  final String name;

  const Tense(this.name);
}
