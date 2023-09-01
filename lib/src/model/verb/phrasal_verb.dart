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
  String get presentParticiple => '${verb.presentParticiple} $particle';

  @override
  String get past => '${verb.past} $particle';

  @override
  String present(Subject subject, [bool enableContraction = true, bool negative = false, bool alternativeContraction = false]) {
    return '${verb.present(subject, enableContraction, negative, alternativeContraction)} $particle';
  }
}
