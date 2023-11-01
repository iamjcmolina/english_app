abstract class AnyAdverb {
  static const adverbPlaceholder = '<Adverb>';
  static const intensifierOrMitigatorPlaceholder =
      '<IntensifierOrMitigatorAdverb>';
  static const adverbPlaceholderEs = '<Adverbio>';
  static const intensifierOrMitigatorPlaceholderEs =
      '<AdverbioIntensificadorOMitigador>';
  bool get isValid;
  String get en;
  String get es;
  bool get isAllowedInFront;
  bool get isAllowedInTheMiddle;
  bool get isAllowedInTheEnd;

  const AnyAdverb();
}
