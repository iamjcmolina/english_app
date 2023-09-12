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
  String get infinitive => '<Bare infinitive verb>';

  @override
  String get pastParticiple => '<Past participle verb>';

  @override
  String get presentParticiple => '<Progressive verb>';

  String get past => '<Simple past verb>';

  @override
  String toString() => infinitive;

  @override
  String present({
    required bool singularFirstPerson,
    required bool singularThirdPerson,
    required bool contraction,
    required bool negativeContraction,
    required bool negative,
  }) => '<Simple present verb>';

  String get presentForSingularThirdPerson => '<Simple present verb>';

  @override
  String simplePast({
    required bool singular,
    required bool negativeContraction,
    required bool negative,
  }) => past;
}
