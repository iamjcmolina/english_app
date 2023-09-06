import 'any_verb.dart';

class UndefinedVerb extends AnyVerb {
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
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
    bool alternativeContraction = false
  }) => '<Simple present verb>';

  String get presentForSingularThirdPerson => '<Simple present verb>';

  @override
  String simplePast({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false}) => past;
}
