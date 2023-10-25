class ModalVerb {
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

  const ModalVerb({
    required this.verb,
    required this.verbContraction,
    required this.negative,
    required this.negativeContraction,
    required this.affirmativeIEs,
    required this.affirmativeSingularYouEs,
    required this.affirmativeHeEs,
    required this.affirmativeWeEs,
    required this.affirmativeTheyEs,
  });
}
