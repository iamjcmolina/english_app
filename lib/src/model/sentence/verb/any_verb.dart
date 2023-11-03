import '../../../extensions/string_extension.dart';
import '../clause/independent_clause.dart';
import '../noun/doer.dart';

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

  String get presentSingularThirdPerson {
    final penultimateLetter = infinitive.charAt(infinitive.length - 2);
    final lastLetter = infinitive.last();
    final lastTwoLetters = infinitive.last(2);
    if (lastLetter == 'o' ||
        lastTwoLetters == 'sh' ||
        lastTwoLetters == 'ch' ||
        lastTwoLetters == 'ss' ||
        lastLetter == 'x' ||
        lastLetter == 'z') {
      return '${infinitive}es';
    } else if (lastLetter == 'y' && penultimateLetter.isConsonant) {
      return '${infinitive.removeLast()}ies';
    }
    return '${infinitive}s';
  }

  const AnyVerb();

  String simplePresent(IndependentClause clause) =>
      clause.hasSingularThirdPersonSubject &&
              clause.isAffirmative &&
              !clause.isAffirmativeEmphasisEnabled &&
              !clause.isModalVerbEnabled
          ? presentSingularThirdPerson
          : infinitive;

  String simplePast(IndependentClause clause);

  String simplePresentEs(IndependentClause clause) {
    return switch (clause.subjectAsDoerEs) {
      Doer.I => presentIEs,
      Doer.you => presentYouEs,
      Doer.we => presentWeEs,
      Doer.they => presentTheyEs,
      Doer.he || Doer.she || Doer.it => presentHeEs,
    };
  }

  String simplePastEs(IndependentClause clause) {
    return switch (clause.subjectAsDoerEs) {
      Doer.I => pastIEs,
      Doer.you => pastYouEs,
      Doer.we => pastWeEs,
      Doer.they => pastTheyEs,
      Doer.he || Doer.she || Doer.it => pastHeEs,
    };
  }

  String futureEs(IndependentClause clause) {
    return switch (clause.subjectAsDoerEs) {
      Doer.I => futureIEs,
      Doer.you => futureYouEs,
      Doer.we => futureWeEs,
      Doer.they => futureTheyEs,
      Doer.he || Doer.she || Doer.it => futureHeEs,
    };
  }

  String conditionalEs(IndependentClause clause) {
    return switch (clause.subjectAsDoerEs) {
      Doer.I => conditionalIEs,
      Doer.you => conditionalYouEs,
      Doer.we => conditionalWeEs,
      Doer.they => conditionalTheyEs,
      Doer.he || Doer.she || Doer.it => conditionalHeEs,
    };
  }
}
