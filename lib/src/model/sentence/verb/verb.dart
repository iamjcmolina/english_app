import 'any_verb.dart';

class Verb extends AnyVerb {
  @override
  bool isTransitive;
  @override
  bool isDitransitive;
  @override
  bool isLinkingVerb;
  @override
  String infinitive;
  @override
  String past;
  @override
  String pastParticiple;

  Verb({
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
  });

  Verb.regular({
    required this.isTransitive,
    required this.isDitransitive,
    required this.infinitive,
    required this.past,
  }): pastParticiple = past, isLinkingVerb = false;

  @override
  bool get isBe => infinitive == 'be';

  @override
  String get presentParticiple => '${infinitive}ing';
}
