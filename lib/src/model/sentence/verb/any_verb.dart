abstract class AnyVerb {
  String get infinitive;
  String get pastParticiple;
  String get progressive;
  String get infinitiveEs;
  String get pastParticipleEs;
  String get progressiveEs;
  String get presentIEs;
  String get presentSingularYouEs;
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs;
  String get presentTheyEs;
  String get pastIEs;
  String get pastSingularYouEs;
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs;
  String get pastWeEs;
  String get pastTheyEs;
  String get futureIEs;
  String get futureSingularYouEs;
  String get futureYouEs => '$futureSingularYouEs/$futureTheyEs';
  String get futureHeEs;
  String get futureWeEs;
  String get futureTheyEs;
  String get conditionalIEs;
  String get conditionalSingularYouEs;
  String get conditionalYouEs => '$conditionalSingularYouEs/$conditionalTheyEs';
  String get conditionalHeEs;
  String get conditionalWeEs;
  String get conditionalTheyEs;
  bool get isTransitive;
  bool get isDitransitive;
  bool get isLinkingVerb;

  const AnyVerb();
}
