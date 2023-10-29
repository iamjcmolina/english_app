import '../../../util/util.dart';

abstract class AnyVerb {
  String get infinitive;
  String get pastParticiple;
  String get progressive;
  String get infinitiveEs;
  String get pastParticipleEs;
  String get progressiveEs;
  String get presentIEs => '${Util.removeLast(presentHeEs)}o';
  String get presentSingularYouEs => '${presentHeEs}s';
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs => '${Util.removeLast(infinitiveEs)}mos';
  String get presentTheyEs => '${presentHeEs}n';
  String get pastIEs;
  String get pastSingularYouEs => '${Util.removeLast(pastWeEs, 3)}ste';
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs => '$_progressiveEsLess4ó';
  String get pastWeEs;
  String get pastTheyEs => switch (Util.last(progressiveEs, 4)) {
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

  String get _progressiveEsLess4 => Util.removeLast(progressiveEs, 4);

  const AnyVerb();
}
