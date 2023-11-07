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
  String get presentIEs;
  String get presentSingularYouEs =>
      presentHeEs.split('/').map((e) => '${e}s').join('/');
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs =>
      infinitiveEs.split('/').map((e) => '${e.removeLast()}mos').join('/');
  String get presentTheyEs =>
      presentHeEs.split('/').map((e) => '${e}n').join('/');
  String get pastIEs;
  String get pastSingularYouEs =>
      pastWeEs.split('/').map((e) => '${e.removeLast(3)}ste').join('/');
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs =>
      progressiveEs.split('/').map((e) => '${e.removeLast(4)}ó').join('/');
  String get pastWeEs;
  String get pastTheyEs => progressiveEs
      .split('/')
      .map((e) => switch (e.removeLast(4)) {
            'ando' => '${e.removeLast(4)}aron',
            _ => '${e.removeLast(4)}eron',
          })
      .join('/');
  String get futureIEs => infinitiveEs.split('/').map((e) => '$eé').join('/');
  String get futureSingularYouEs =>
      infinitiveEs.split('/').map((e) => '$eás').join('/');
  String get futureYouEs => '$futureSingularYouEs/$futureTheyEs';
  String get futureHeEs => infinitiveEs.split('/').map((e) => '$eá').join('/');
  String get futureWeEs =>
      infinitiveEs.split('/').map((e) => '${e}emos').join('/');
  String get futureTheyEs =>
      infinitiveEs.split('/').map((e) => '$eán').join('/');
  String get conditionalIEs =>
      infinitiveEs.split('/').map((e) => '$eía').join('/');
  String get conditionalSingularYouEs =>
      infinitiveEs.split('/').map((e) => '$eías').join('/');
  String get conditionalYouEs => '$conditionalSingularYouEs/$conditionalTheyEs';
  String get conditionalHeEs =>
      infinitiveEs.split('/').map((e) => '$eía').join('/');
  String get conditionalWeEs =>
      infinitiveEs.split('/').map((e) => '$eíamos').join('/');
  String get conditionalTheyEs =>
      infinitiveEs.split('/').map((e) => '$eían').join('/');
  bool get isTransitive;
  bool get isDitransitive;
  bool get canBeLinkingVerb;

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

  bool get isAlwaysLinkingVerb => false;

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
