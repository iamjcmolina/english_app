class ModalVerb {
  static List<ModalVerb> modalVerbs = const [
    ModalVerb("can", 'can', 'cannot', "can't", false),
    ModalVerb('could', 'could', 'could not', "couldn't", false),
    ModalVerb('may', 'may', 'may not', "may not", false),
    ModalVerb('might', 'might', 'might not', "might not", false),
    ModalVerb('will', "'ll", 'will not', "won't", true),
    ModalVerb('shall', 'shall', 'shall not', "shan't", false),
    ModalVerb('should', 'should', 'should not', "shouldn't", false),
    ModalVerb('must', 'must', 'must not', "mustn't", false),
    ModalVerb('would', "'d", 'would not', "wouldn't", true),
  ];

  final String affirmative;
  final String affirmativeContraction;
  final String negative;
  final String negativeContraction;
  final bool hasContraction;

  const ModalVerb(
    this.affirmative,
    this.affirmativeContraction,
    this.negative,
    this.negativeContraction,
    this.hasContraction,
  );

  String affirmativeValue([bool contraction = true]) => contraction
      ? affirmativeContraction
      : affirmative;

  String negativeValue([bool contraction = true]) => contraction
      ? negativeContraction
      : negative;
}
