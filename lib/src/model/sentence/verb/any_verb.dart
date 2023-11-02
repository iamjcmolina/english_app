import '../../../extensions/string_extension.dart';

abstract class AnyVerb {
  String get infinitive;
  String get pastParticiple;
  String get progressive;
  String get infinitiveEs;
  String get pastParticipleEs;
  String get progressiveEs;
  String get presentIEs => '${presentHeEs.removeLast()}o';
  String get presentSingularYouEs => '${presentHeEs}s';
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs => '${infinitiveEs.removeLast()}mos';
  String get presentTheyEs => '${presentHeEs}n';
  String get pastIEs;
  String get pastSingularYouEs => '${pastWeEs.removeLast(3)}ste';
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs => '${progressiveEs.removeLast(4)}ó';
  String get pastWeEs;
  String get pastTheyEs => switch (progressiveEs.removeLast(4)) {
        'ando' => '${progressiveEs.removeLast(4)}aron',
        _ => '${progressiveEs.removeLast(4)}eron',
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

  const AnyVerb();
}
