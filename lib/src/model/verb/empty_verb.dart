import '../noun/subject.dart';
import 'verb.dart';

class EmptyVerb implements Verb {
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
  String present(Subject subject, [bool enableContraction = true, bool negative = false, bool alternativeContraction = false]) => '<Simple present verb>';

  @override
  String toString() => infinitive;
}
