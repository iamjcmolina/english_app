import 'any_verb.dart';
import 'verb.dart';

class PhrasalVerb extends AnyVerb {
  final bool separable;
  @override
  final String infinitiveEs;
  @override
  final String pastParticipleEs;
  @override
  final String progressiveEs;
  @override
  final String presentHeEs;
  @override
  final String pastIEs;
  @override
  final String pastWeEs;
  final String particle; // Adjective | Adverb | Preposition
  final Verb verb;
  @override
  final bool isDitransitive;
  @override
  final bool isTransitive;
  @override
  final bool isLinkingVerb;

  @override
  String get infinitive => '${verb.infinitive} $particle';

  String get past => '${verb.past} $particle';

  @override
  String get pastParticiple => '${verb.pastParticiple} $particle';

  @override
  String get progressive => '${verb.progressive} $particle';

  PhrasalVerb({
    required String infinitiveVerb,
    required String pastVerb,
    required String pastParticipleVerb,
    required this.particle,
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentHeEs,
    required this.pastIEs,
    required this.pastWeEs,
    required this.separable,
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
  }) : verb = Verb(
            infinitive: infinitiveVerb,
            past: pastVerb,
            pastParticiple: pastParticipleVerb,
            infinitiveEs: infinitiveEs,
            pastParticipleEs: pastParticipleEs,
            progressiveEs: progressiveEs,
            presentHeEs: presentHeEs,
            pastIEs: pastIEs,
            pastWeEs: pastWeEs,
            isTransitive: isTransitive,
            isDitransitive: isDitransitive,
            isLinkingVerb: isLinkingVerb);
}
