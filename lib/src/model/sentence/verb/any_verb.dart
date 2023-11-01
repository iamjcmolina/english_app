import '../../../util/util.dart';

abstract class AnyVerb {
  static const infinitivePlaceholder = '<InfinitiveVerb>';
  static const pastPlaceholder = '<PastVerb>';
  static const presentPlaceholder = '<PresentVerb>';
  static const pastParticiplePlaceholder = '<PastParticipleVerb>';
  static const progressivePlaceholder = '<ProgressiveVerb>';
  static const infinitivePlaceholderEs = '<VerbInfinitivo>';
  static const pastPlaceholderEs = '<VerboPasado>';
  static const presentPlaceholderEs = '<VerbPresente>';
  static const futurePlaceholderEs = '<VerbFuturo>';
  static const pastParticiplePlaceholderEs = '<VerbPasadoParticipio>';
  static const progressivePlaceholderEs = '<VerboProgresivo>';
  static const conditionalPlaceholderEs = '<VerboCondicional>';
  String get infinitive;
  String get pastParticiple;
  String get progressive;
  String get infinitiveEs;
  String get pastParticipleEs;
  String get progressiveEs;
  String get presentIEs => Util.replaceLast(presentHeEs, 'o');
  String get presentSingularYouEs => '${presentHeEs}s';
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs => '${Util.lessLast(infinitiveEs)}mos';
  String get presentTheyEs => '${presentHeEs}n';
  String get pastIEs;
  String get pastSingularYouEs => Util.replaceLast(pastWeEs, 'ste');
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs => '$_progressiveEsLess4ó';
  String get pastWeEs;
  String get pastTheyEs => switch (_progressiveEsLess4) {
        'ando' => '${_progressiveEsLess4}aron',
        _ => '${_progressiveEsLess4}eron',
      };
  String get futureIEs => '$infinitiveEsé';
  String get futureSingularYouEs => '$infinitiveEsás';
  String get futureYouEs => '$futureSingularYouEs/$futureTheyEs';
  String get futureHeEs => '$infinitiveEsá';
  String get futureWeEs => '${infinitiveEs}emos';
  String get futureTheyEs => '$infinitiveEsán';
  String get conditionalIEs => '$infinitiveEsía';
  String get conditionalSingularYouEs => '$infinitiveEsías';
  String get conditionalYouEs => '$conditionalSingularYouEs/$conditionalTheyEs';
  String get conditionalHeEs => '$infinitiveEsía';
  String get conditionalWeEs => '$infinitiveEsíamos';
  String get conditionalTheyEs => '$infinitiveEsían';
  bool get isTransitive;
  bool get isDitransitive;
  bool get isLinkingVerb;

  String get _progressiveEsLess4 => Util.lessLast(progressiveEs, 4);

  const AnyVerb();
}
