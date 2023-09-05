import 'any_verb.dart';

class UndefinedVerb implements AnyVerb {
  @override
  bool get isTransitive => false;

  @override
  bool get isDitransitive => false;

  @override
  bool get isLinkingVerb => false;

  @override
  bool get isBe => false;

  @override
  String get infinitive => '<Bare infinitive verb>';

  @override
  String get pastParticiple => '<Past participle verb>';

  @override
  String get presentParticiple => '<Progressive verb>';

  @override
  String get past => '<Simple past verb>';

  @override
  String toString() => infinitive;
}
