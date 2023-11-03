class ModalVerb {
  static const List<ModalVerb> modalVerbs = [
    ModalVerb(
        verb: 'can',
        verbContraction: "can",
        negative: 'cannot',
        negativeWithVerbContraction: "cannot",
        negativeContraction: "can't",
        affirmativeIEs: 'puedo',
        affirmativeSingularYouEs: 'puedes',
        affirmativeHeEs: 'puede',
        affirmativeWeEs: 'podemos',
        affirmativeTheyEs: 'pueden'),
    ModalVerb(
        verb: 'could',
        verbContraction: "could",
        negative: 'could not',
        negativeWithVerbContraction: "could not",
        negativeContraction: "couldn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'may',
        verbContraction: "may",
        negative: 'may not',
        negativeWithVerbContraction: "may not",
        negativeContraction: "mayn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'might',
        verbContraction: "might",
        negative: 'might not',
        negativeWithVerbContraction: "might not",
        negativeContraction: "mightn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'must',
        verbContraction: "must",
        negative: 'must not',
        negativeWithVerbContraction: "must not",
        negativeContraction: "mustn't",
        affirmativeIEs: 'debo',
        affirmativeSingularYouEs: 'debes',
        affirmativeHeEs: 'debe',
        affirmativeWeEs: 'debemos',
        affirmativeTheyEs: 'deben'),
    ModalVerb(
        verb: 'should',
        verbContraction: "should",
        negative: 'should not',
        negativeWithVerbContraction: "should not",
        negativeContraction: "shouldn't",
        affirmativeIEs: 'debería',
        affirmativeSingularYouEs: 'deberías',
        affirmativeHeEs: 'debería',
        affirmativeWeEs: 'deberíamos',
        affirmativeTheyEs: 'deberían'),
    ModalVerb(
        verb: 'would',
        verbContraction: "'d",
        negative: 'would not',
        negativeWithVerbContraction: "'d not",
        negativeContraction: "wouldn't"),
  ];
  final String verb;
  final String verbContraction;
  final String negative;
  final String negativeWithVerbContraction;
  final String negativeContraction;
  final String affirmativeIEs;
  final String affirmativeSingularYouEs;
  final String affirmativeHeEs;
  final String affirmativeWeEs;
  final String affirmativeTheyEs;

  bool get isWould => verb.toLowerCase() == 'would';

  bool get hasVerbContraction => verb != verbContraction;

  String get affirmativeYouEs => '$affirmativeSingularYouEs/$affirmativeTheyEs';

  const ModalVerb({
    required this.verb,
    required this.verbContraction,
    required this.negative,
    required this.negativeWithVerbContraction,
    required this.negativeContraction,
    this.affirmativeIEs = '',
    this.affirmativeSingularYouEs = '',
    this.affirmativeHeEs = '',
    this.affirmativeWeEs = '',
    this.affirmativeTheyEs = '',
  });
}
