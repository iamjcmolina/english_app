class ModalVerb {
  static const List<String> modalVerbs = ['can','could','may','might','will','shall','should', 'must','would'];
  static const List<String> negativeModalVerbs = ["cannot","could not","may not","might not","will not","shall not","should not", "must not","would not"];
  static const List<String> negativeContractedModalVerbs = ["can't","couldn't","may not","might not","won't","shan't","shouldn't", "mustn't","wouldn't"];

  String value;

  ModalVerb({required this.value});

  String negative([bool enableContraction = true]) =>
      enableContraction? negativeContractedModalVerbs.elementAt(modalVerbs.indexOf(value))
          : negativeModalVerbs[modalVerbs.indexOf(value)];

  @override
  String toString() => value;
}
