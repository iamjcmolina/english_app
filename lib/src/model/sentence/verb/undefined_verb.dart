import 'any_verb.dart';

class UndefinedVerb extends AnyVerb {
  const UndefinedVerb();

  @override
  bool get isTransitive => false;

  @override
  bool get isDitransitive => false;

  @override
  bool get isLinkingVerb => false;

  @override
  String get infinitive => '<BareInfinitiveVerb>';

  @override
  String get pastParticiple => '<PastParticipleVerb>';

  @override
  String get presentParticiple => '<ProgressiveVerb>';

  String get past => '<SimplePastVerb>';

  @override
  String toString() => infinitive;

  @override
  String present({
    required bool singularFirstPerson,
    required bool singularThirdPerson,
    required bool contraction,
    required bool negativeContraction,
    required bool negative,
  }) => '<SimplePresentVerb>';

  String get presentForSingularThirdPerson => '<SimplePresentVerb>';

  @override
  String simplePast({
    required bool isPlural,
    required bool negativeContraction,
    required bool negative,
  }) => past;
}
