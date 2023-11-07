import 'verb.dart';

class PhrasalVerb extends Verb {
  final String particle; // Adjective | Adverb | Preposition
  final bool isSeparable;

  @override
  String get infinitive => '${super.infinitive} $particle';

  @override
  String get past => '${super.past} $particle';

  @override
  String get pastParticiple => '${super.pastParticiple} $particle';

  @override
  String get progressive => '${super.progressive} $particle';

  @override
  String get presentSingularThirdPerson =>
      super.presentSingularThirdPerson + particle;

  const PhrasalVerb({
    required super.infinitive,
    required super.past,
    required super.pastParticiple,
    required this.particle,
    required super.infinitiveEs,
    required super.pastParticipleEs,
    required super.progressiveEs,
    required super.presentIEs,
    required super.presentHeEs,
    required super.pastIEs,
    required super.pastWeEs,
    required super.isTransitive,
    required super.isDitransitive,
    super.canBeLinkingVerb = false,
    required this.isSeparable,
  });
}
