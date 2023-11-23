import '../clause/independent_clause.dart';
import 'any_verb.dart';

class Verb extends AnyVerb {
  @override
  final String infinitive;
  final String past;
  @override
  final String pastParticiple;
  @override
  final String progressive;
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
  final bool isTransitive;
  @override
  final bool isDitransitive;
  @override
  final bool canBeLinkingVerb;
  @override
  final String help;

  @override
  bool get isAlwaysLinkingVerb =>
      infinitive == 'become' || infinitive == 'seem';

  const Verb({
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
    required this.progressive,
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
    required this.help,
    required this.isTransitive,
    required this.isDitransitive,
    this.canBeLinkingVerb = false,
  });

  @override
  String simplePast(IndependentClause clause) =>
      clause.isAffirmative && !clause.isAffirmativeEmphasisEnabled
          ? past
          : infinitive;
}
