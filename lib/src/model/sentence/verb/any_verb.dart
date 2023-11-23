import '../../../extensions/string_extension.dart';
import '../clause/independent_clause.dart';
import '../noun/doer.dart';

abstract class AnyVerb {
  static const divisor = ',';
  String get infinitive;
  String get pastParticiple;
  String get progressive;
  String get infinitiveEs;
  String get pastParticipleEs;
  String get progressiveEs;
  String get presentIEs;
  String get presentSingularYouEs => presentHeEs
      .split(divisor)
      .map((e) => e.hasWords()
          ? e.isFirstWord('se')
              ? '${e.replaceFirst('se', 'te')}s'
              : e.isFirstWord('es')
                  ? e.replaceFirst('es', 'eres')
                  : e.appendToFirstWord('s')
          : '${e}s')
      .join(divisor);
  String get presentYouEs => '$presentSingularYouEs/$presentTheyEs';
  String get presentHeEs;
  String get presentWeEs => infinitiveEs
      .split(divisor)
      .map((e) => e.hasWords()
          ? e.isFirstWord('ser')
              ? e.replaceFirst('ser', 'somos')
              : e.isFirstWord('ir')
                  ? e.replaceFirst('ir', 'vamos')
                  : e.replaceFirstWord('${e.firstWord().removeLast()}mos')
          : e.endsWith('rse')
              ? (e == 'irse' ? 'nos vamos' : 'nos ${e.removeLast(3)}mos')
              : (e == 'ir' ? 'vamos' : '${e.removeLast()}mos'))
      .join(divisor);
  String get presentTheyEs => presentHeEs
      .split(divisor)
      .map((e) => e.hasWords()
          ? e.isFirstWord('se')
              ? '${e}n'
              : e.firstWord() == 'ser'
                  ? 'somos'
                  : e.appendToFirstWord('n')
          : '${e}n')
      .join(divisor);
  String get pastIEs;
  String get pastSingularYouEs => pastWeEs
      .split(divisor)
      .map((e) => e.startsWith('nos ')
          ? 'te ${e.removeFirst(4).removeLast(3)}ste'
          : e.hasWords()
              ? e.replaceFirstWord('${e.firstWord().removeLast(3)}ste')
              : '${e.removeLast(3)}ste')
      .join(divisor);
  String get pastYouEs => '$pastSingularYouEs/$pastTheyEs';
  String get pastHeEs => progressiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'se ${e.removeLast(6)}ó'
          : e.hasWords()
              ? e.replaceFirstWord('${e.firstWord().removeLast(4)}ó')
              : '${e.removeLast(4)}ó')
      .join(divisor);
  String get pastWeEs;
  String get pastTheyEs => progressiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? e.endsWith('andose')
              ? 'se ${e.removeLast(6)}aron'
              : 'se ${e.removeLast(6)}eron'
          : e.hasWords()
              ? e.firstWord() == 'estando'
                  ? e.replaceFirstWord('estuvieron')
                  : e.replaceFirstWord(e.firstWord().endsWith('ando')
                      ? '${e.firstWord().removeLast(4)}aron'
                      : '${e.firstWord().removeLast(4)}eron')
              : e.endsWith('ando')
                  ? '${e.removeLast(4)}aron'
                  : '${e.removeLast(4)}eron')
      .join(divisor);
  String get futureIEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'me ${e.removeLast(2)}é'
          : e.hasWords()
              ? e.appendToFirstWord('é')
              : '$eé')
      .join(divisor);
  String get futureSingularYouEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'te ${e.removeLast(2)}ás'
          : e.hasWords()
              ? e.appendToFirstWord('ás')
              : '$eás')
      .join(divisor);
  String get futureYouEs => '$futureSingularYouEs/$futureTheyEs';
  String get futureHeEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'se ${e.removeLast(2)}á'
          : e.hasWords()
              ? e.appendToFirstWord('á')
              : '$eá')
      .join(divisor);
  String get futureWeEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'nos ${e.removeLast(2)}emos'
          : e.hasWords()
              ? e.appendToFirstWord('emos')
              : '${e}emos')
      .join(divisor);
  String get futureTheyEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'se ${e.removeLast(2)}án'
          : e.hasWords()
              ? e.appendToFirstWord('án')
              : '$eán')
      .join(divisor);
  String get conditionalIEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'me ${e.removeLast(2)}ía'
          : e.hasWords()
              ? e.appendToFirstWord('ía')
              : '$eía')
      .join(divisor);
  String get conditionalSingularYouEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'te ${e.removeLast(2)}ías'
          : e.hasWords()
              ? e.appendToFirstWord('ías')
              : '$eías')
      .join(divisor);
  String get conditionalYouEs => '$conditionalSingularYouEs/$conditionalTheyEs';
  String get conditionalHeEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'se ${e.removeLast(2)}ía'
          : e.hasWords()
              ? e.appendToFirstWord('ía')
              : '$eía')
      .join(divisor);
  String get conditionalWeEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'nos ${e.removeLast(2)}íamos'
          : e.hasWords()
              ? e.appendToFirstWord('íamos')
              : '$eíamos')
      .join(divisor);
  String get conditionalTheyEs => infinitiveEs
      .split(divisor)
      .map((e) => e.endsWith('se')
          ? 'se ${e.removeLast(2)}ían'
          : e.hasWords()
              ? e.appendToFirstWord('ían')
              : '$eían')
      .join(divisor);
  bool get isTransitive;
  bool get isDitransitive;
  bool get canBeLinkingVerb;
  String get help => '';

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
