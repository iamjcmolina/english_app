import '../clause/independent_clause.dart';
import 'any_verb.dart';

class Have extends AnyVerb {
  static const tener = Have(
      infinitiveEs: 'tener',
      pastParticipleEs: 'tenido',
      progressiveEs: 'teniendo',
      presentIEs: 'tengo',
      presentSingularYouEs: 'tienes',
      presentHeEs: 'tiene',
      presentWeEs: 'tenemos',
      presentTheyEs: 'tienen',
      pastIEs: 'tuve',
      pastSingularYouEs: 'tuviste',
      pastHeEs: 'tuvo',
      pastWeEs: 'tuvimos',
      pastTheyEs: 'tuvieron',
      futureIEs: 'tendré',
      futureSingularYouEs: 'tendrás',
      futureHeEs: 'tendrá',
      futureWeEs: 'tendremos',
      futureTheyEs: 'tendrán',
      conditionalIEs: 'tendría',
      conditionalSingularYouEs: 'tendrías',
      conditionalHeEs: 'tendría',
      conditionalWeEs: 'tendríamos',
      conditionalTheyEs: 'tendrían',
      meansHaber: false);
  static const haber = Have(
      infinitiveEs: 'haber',
      pastParticipleEs: 'habido',
      progressiveEs: 'habiendo',
      presentIEs: 'he',
      presentSingularYouEs: 'has',
      presentHeEs: 'ha',
      presentWeEs: 'hemos',
      presentTheyEs: 'han',
      pastIEs: 'había',
      pastSingularYouEs: 'habías',
      pastHeEs: 'había',
      pastWeEs: 'habíamos',
      pastTheyEs: 'habían',
      futureIEs: 'habré',
      futureSingularYouEs: 'habrás',
      futureHeEs: 'habrá',
      futureWeEs: 'habremos',
      futureTheyEs: 'habrán',
      conditionalIEs: 'habría',
      conditionalSingularYouEs: 'habrías',
      conditionalHeEs: 'habría',
      conditionalWeEs: 'habremos',
      conditionalTheyEs: 'habrían',
      meansHaber: true);
  @override
  final String infinitive = 'have';
  @override
  final String presentSingularThirdPerson = 'has';
  final String past = 'had';
  @override
  final String pastParticiple = 'had';
  @override
  final String progressive = 'having';
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
  final bool isTransitive = true;
  @override
  final bool isDitransitive = false;
  @override
  final bool isLinkingVerb = false;
  final bool meansHaber;

  const Have({
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
    required this.meansHaber,
  });

  @override
  String simplePresent(IndependentClause clause) =>
      meansHaber ? _auxSimplePresent(clause) : super.simplePresent(clause);

  String _auxSimplePresent(IndependentClause clause) => clause.isNegative
      ? clause.isVerbContractionEnabled
          ? clause.hasSingularThirdPersonSubject
              ? "'s not"
              : "'ve not"
          : clause.isNegativeContractionEnabled
              ? clause.hasSingularThirdPersonSubject
                  ? "hasn't"
                  : "haven't"
              : clause.hasSingularThirdPersonSubject
                  ? 'has not'
                  : 'have not'
      : clause.isAffirmative && clause.isVerbContractionEnabled
          ? clause.hasSingularThirdPersonSubject
              ? "'s"
              : "'ve"
          : clause.hasSingularThirdPersonSubject
              ? 'has'
              : 'have';

  @override
  String simplePast(IndependentClause clause) =>
      meansHaber ? _auxSimplePast(clause) : past;

  String _auxSimplePast(IndependentClause clause) => clause.isNegative
      ? clause.isVerbContractionEnabled
          ? "'d not"
          : clause.isNegativeContractionEnabled
              ? "hadn't"
              : "had not"
      : clause.isAffirmative && clause.isVerbContractionEnabled
          ? "'d"
          : "had";

  @override
  String simplePresentEs(IndependentClause clause) {
    final affirmative = super.simplePresentEs(clause);
    return meansHaber && clause.isNegative ? 'no $affirmative' : affirmative;
  }

  @override
  String simplePastEs(IndependentClause clause) {
    final affirmative = super.simplePastEs(clause);
    return meansHaber && clause.isNegative ? 'no $affirmative' : affirmative;
  }
}
