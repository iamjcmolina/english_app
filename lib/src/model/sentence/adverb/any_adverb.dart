abstract class AnyAdverb {
  static const adverbPlaceholder = '<Adverb>';
  static const intensifierOrMitigatorPlaceholder =
      '<IntensifierOrMitigatorAdverb>';
  static const adverbPlaceholderEs = '<Adverbio>';
  static const intensifierOrMitigatorPlaceholderEs =
      '<AdverbioIntensificadorOMitigador>';
  String get en;
  String get es;
  bool get isAllowedInFront;
  bool get isAllowedInTheMiddle;
  bool get isAllowedInTheEnd;

  const AnyAdverb();
}
