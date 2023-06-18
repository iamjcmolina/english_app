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
  String get progressive => '<Progressive verb>';

  @override
  String get simplePast => '<Simple past verb>';

  @override
  String simplePresent(Subject subject) => '<Simple present verb>';
}
