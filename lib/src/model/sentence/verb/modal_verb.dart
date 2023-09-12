class ModalVerb {
  static List<ModalVerb> modalVerbs = const [
    ModalVerb("can", 'can', 'cannot', "can't"),
    ModalVerb('could', 'could', 'could not', "couldn't"),
    ModalVerb('may', 'may', 'may not', "may not"),
    ModalVerb('might', 'might', 'might not', "might not"),
    ModalVerb('will', "'ll'", 'will not', "won't"),
    ModalVerb('shall', 'shall', 'shall not', "shan't"),
    ModalVerb('should', 'should', 'should not', "shouldn't"),
    ModalVerb('must', 'must', 'must not', "mustn't"),
    ModalVerb('would', "'d", 'would not', "wouldn't"),
  ];

  final String affirmative;
  final String affirmativeContraction;
  final String negative;
  final String negativeContraction;

  const ModalVerb(
    this.affirmative,
    this.affirmativeContraction,
    this.negative,
    this.negativeContraction,
  );

  String affirmativeValue([bool contraction = true]) => contraction
      ? affirmativeContraction
      : affirmative;

  String negativeValue([bool contraction = true]) => contraction
      ? negativeContraction
      : negative;
}
