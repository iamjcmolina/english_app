import '../clause/independent_clause_settings.dart';
import '../noun/any_noun.dart';
import 'be.dart';
import 'value/verb_tense.dart';

abstract class AnyVerb {
  const AnyVerb();

  bool get isTransitive;
  bool get isDitransitive;
  bool get isLinkingVerb;
  String get infinitive;
  String get presentParticiple;
  String get pastParticiple;

  String present({
    required bool singularFirstPerson,
    required bool singularThirdPerson,
    required bool contraction,
    required bool negativeContraction,
    required bool negative,
  });

  String simplePast({
    required bool isPlural,
    required bool negativeContraction,
    required bool negative,
  });

  static String verbToString(AnyVerb verb, AnyNoun subject, IndependentClauseSettings settings) {
    VerbTense verbTense = AnyVerb.verbTense(verb, settings);
    if (verbTense == VerbTense.present) {
      return verb.present(
        singularFirstPerson: subject.isSingularFirstPerson,
        singularThirdPerson: subject.isSingularThirdPerson,
        contraction: !settings.isInterrogative && settings.contraction,
        negativeContraction: settings.negativeContraction,
        negative: settings.isNegative,
      );
    } else if (verbTense == VerbTense.past) {
      return verb.simplePast(
        isPlural: subject.countability == Countability.plural,
        negativeContraction: settings.negativeContraction,
        negative: settings.isNegative,
      );
    } else if (verbTense == VerbTense.presentParticiple) {
      return verb.presentParticiple;
    } else if (verbTense == VerbTense.pastParticiple) {
      return verb.pastParticiple;
    }
    return verb.infinitive;
  }

  static VerbTense verbTense(AnyVerb verb, IndependentClauseSettings settings) {
    if (settings.isAffirmative) {
      if (settings.isSimplePresent) {
        return settings.modalVerb
            || (verb is! Be && settings.affirmativeEmphasis)
            ? VerbTense.infinitive
            : VerbTense.present;
      } else if (settings.isSimplePast) {
        return verb is! Be
            && settings.affirmativeEmphasis
            ? VerbTense.infinitive : VerbTense.past;
      }
    } else if (settings.isNegative && settings.isSimplePresent) {
      return settings.modalVerb || verb is! Be
          ? VerbTense.infinitive : VerbTense.present;
    }
    if (settings.isSimplePresent) {
      return verb is Be && settings.modalVerb
          ? VerbTense.infinitive : VerbTense.present;
    } else if (settings.isSimplePast) {
      return VerbTense.past;
    } else if (settings.isSimpleFuture) {
      return VerbTense.infinitive;
    } else if (settings.isSimplePresentPerfect
        || settings.isSimplePastPerfect
        || settings.isSimpleFuturePerfect) {
      return VerbTense.pastParticiple;
    } else {
      return VerbTense.presentParticiple;
    }
  }
}
