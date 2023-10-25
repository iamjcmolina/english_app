import 'any_verb.dart';

class Verb extends AnyVerb {
  @override
  final String infinitive;
  final String past;
  @override
  final String pastParticiple;
  @override
  final String infinitiveEs;
  @override
  final String pastParticipleEs;
  @override
  final String progressiveEs;
  @override
  final String presentIEs;
  @override
  final String presentSingularYouEs;
  @override
  final String presentHeEs;
  @override
  final String presentWeEs;
  @override
  final String presentTheyEs;
  @override
  final String pastIEs;
  @override
  final String pastSingularYouEs;
  @override
  final String pastHeEs;
  @override
  final String pastWeEs;
  @override
  final String pastTheyEs;
  @override
  final String futureIEs;
  @override
  final String futureSingularYouEs;
  @override
  final String futureHeEs;
  @override
  final String futureWeEs;
  @override
  final String futureTheyEs;
  @override
  final String conditionalIEs;
  @override
  final String conditionalSingularYouEs;
  @override
  final String conditionalHeEs;
  @override
  final String conditionalWeEs;
  @override
  final String conditionalTheyEs;
  @override
  final bool isTransitive;
  @override
  final bool isDitransitive;
  @override
  final bool isLinkingVerb;

  @override
  String get progressive => '${infinitive}ing';

  const Verb({
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentIEs,
    required this.presentSingularYouEs,
    required this.presentHeEs,
    required this.presentWeEs,
    required this.presentTheyEs,
    required this.pastIEs,
    required this.pastSingularYouEs,
    required this.pastHeEs,
    required this.pastWeEs,
    required this.pastTheyEs,
    required this.futureIEs,
    required this.futureSingularYouEs,
    required this.futureHeEs,
    required this.futureWeEs,
    required this.futureTheyEs,
    required this.conditionalIEs,
    required this.conditionalSingularYouEs,
    required this.conditionalHeEs,
    required this.conditionalWeEs,
    required this.conditionalTheyEs,
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
  });
}
