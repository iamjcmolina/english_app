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
  final String presentHeEs;
  @override
  final String pastIEs;
  @override
  final String pastWeEs;
  @override
  final bool isTransitive;
  @override
  final bool isDitransitive;
  @override
  final bool isLinkingVerb;

  const Verb({
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentHeEs,
    required this.pastIEs,
    required this.pastWeEs,
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
  });

  @override
  String get progressive => '${infinitive}ing';
}
