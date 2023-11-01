class ModalVerb {
  static const List<ModalVerb> modalVerbs = [
    ModalVerb('can', "can", 'cannot', "can't", 'puedo', 'puedes', 'puede',
        'podemos', 'pueden'),
    ModalVerb('could', "could", 'could not', "couldn't", 'podría', 'podrías',
        'podría', 'podríamos', 'podrían'),
    ModalVerb('may', "may", 'may not', "mayn't", 'podría', 'podrías', 'podría',
        'podríamos', 'podrían'),
    ModalVerb('might', "might", 'might not', "mightn't", 'podría', 'podrías',
        'podría', 'podríamos', 'podrían'),
    ModalVerb('must', "must", 'must not', "mustn't", 'debo', 'debes', 'debe',
        'debemos', 'deben'),
    ModalVerb('should', "should", 'should not', "shouldn't", 'debería',
        'deberías', 'debería', 'deberíamos', 'deberían'),
    ModalVerb('would', "'d", 'would not', "wouldn't", '', '', '', '', ''),
  ];
  final String verb;
  final String verbContraction;
  final String negative;
  final String negativeContraction;
  final String affirmativeIEs;
  final String affirmativeSingularYouEs;
  final String affirmativeHeEs;
  final String affirmativeWeEs;
  final String affirmativeTheyEs;

  String get affirmativeYouEs => '$affirmativeSingularYouEs/$affirmativeTheyEs';
  String get negativeVerbContraction => '$verbContraction not';
  bool get isWould => verb.toLowerCase() == 'would';
  bool get hasVerbContraction => verb != verbContraction;

  const ModalVerb(
    this.verb,
    this.verbContraction,
    this.negative,
    this.negativeContraction,
    this.affirmativeIEs,
    this.affirmativeSingularYouEs,
    this.affirmativeHeEs,
    this.affirmativeWeEs,
    this.affirmativeTheyEs,
  );
}
