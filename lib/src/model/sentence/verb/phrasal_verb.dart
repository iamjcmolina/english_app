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
    required super.progressive,
    required super.infinitiveEs,
    required super.pastParticipleEs,
    required super.progressiveEs,
    required super.presentIEs,
    required super.presentSingularYouEs,
    required super.presentHeEs,
    required super.presentWeEs,
    required super.presentTheyEs,
    required super.pastIEs,
    required super.pastSingularYouEs,
    required super.pastHeEs,
    required super.pastWeEs,
    required super.pastTheyEs,
    required super.isTransitive,
    required super.isDitransitive,
    super.canBeLinkingVerb = false,
    required super.help,
    required this.particle,
    required this.isSeparable,
  });
}
