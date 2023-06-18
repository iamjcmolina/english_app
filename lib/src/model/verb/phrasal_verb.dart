import '../noun/subject.dart';
import 'verb.dart';
import 'verb_word.dart';
import 'phrasal_verb_particle.dart';

class PhrasalVerb extends Verb {
  bool separable;
  VerbWord verb;
  PhrasalVerbParticle particle;

  PhrasalVerb({required this.separable, required this.verb, required this.particle});

  @override
  bool get isTransitive => verb.isTransitive;

  @override
  bool get isDitransitive => verb.isDitransitive;

  @override
  bool get isLinkingVerb => false;

  @override
  bool get isBe => false;

  @override
  String get infinitive => '${verb.infinitive} $particle';

  @override
  String get pastParticiple => '${verb.pastParticiple} $particle';

  @override
  String get progressive => '${verb.progressive} $particle';

  @override
  String get simplePast => '${verb.simplePast} $particle';

  @override
  String simplePresent(Subject subject) {
    return '${verb.simplePresent(subject)} $particle';
  }
}
