import '../clause/independent_clause.dart';
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
  final bool canBeLinkingVerb;
  @override
  final String help;

  @override
  String get progressive => '${infinitive}ing';

  @override
  bool get isAlwaysLinkingVerb =>
      infinitive == 'become' || infinitive == 'seem';

  const Verb({
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentIEs,
    required this.presentHeEs,
    required this.pastIEs,
    required this.pastWeEs,
    required this.isTransitive,
    required this.isDitransitive,
    this.canBeLinkingVerb = false,
    required this.help,
  });

  @override
  String simplePast(IndependentClause clause) =>
      clause.isAffirmative && !clause.isAffirmativeEmphasisEnabled
          ? past
          : infinitive;
}
