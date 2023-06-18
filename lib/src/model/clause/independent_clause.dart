import '../../util/speech.dart';
import '../adverb/adverb.dart';
import '../noun/direct_object.dart';
import '../noun/empty_subject.dart';
import '../noun/indirect_object.dart';
import '../noun/noun_phrase.dart';
import '../noun/subject.dart';
import '../noun/pronoun.dart';
import '../noun/subject_type.dart';
import '../subject_complement.dart';
import '../tense.dart';
import '../verb/modal_verb.dart';
import '../verb/empty_verb.dart';
import '../verb/phrasal_verb.dart';
import '../verb/phrasal_verb_particle.dart';
import '../verb/verb.dart';
import '../verb/verb_type.dart';
import 'clause_type.dart';

class IndependentClause {
  bool enableAffirmativeEmphasis;
  bool enableContractions;
  bool enableSecondContractionToBe;
  bool enableModalVerb;
  bool enableDirectObject;
  ClauseType type;
  Tense tense;
  Adverb? beginningAdverb;
  SubjectType subjectType;
  Subject? subject;
  ModalVerb? modalVerb;
  Adverb? midAdverb;
  VerbType verbType;
  Verb? verb;
  IndirectObject? indirectObject;
  DirectObject? directObject;
  List<Adverb> adverbs;
  SubjectComplement? subjectComplement;

  IndependentClause({
    this.enableAffirmativeEmphasis = false,
    this.enableContractions = true,
    this.enableSecondContractionToBe = false,
    this.enableModalVerb = false,
    this.enableDirectObject = false,
    required this.type,
    required this.tense,
    this.beginningAdverb,
    this.subjectType = SubjectType.pronoun,
    required this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verbType = VerbType.verbWord,
    required this.verb,
    this.indirectObject,
    this.directObject,
    this.adverbs = const [],
    this.subjectComplement,
  });

  IndependentClause copyWith({
    bool? enableAffirmativeEmphasis,
    bool? enableContractions,
    bool? enableSecondContractionToBe,
    bool? enableModalVerb,
    bool? enableDirectObject,
    ClauseType? type,
    Tense? tense,
    Adverb? beginningAdverb,
    SubjectType? subjectType,
    Subject? subject,
    ModalVerb? modalVerb,
    Adverb? midAdverb,
    VerbType? verbType,
    Verb? verb,
    IndirectObject? indirectObject,
    DirectObject? directObject,
    List<Adverb>? adverbs,
    SubjectComplement? subjectComplement,
  }) => IndependentClause(
    enableAffirmativeEmphasis: enableAffirmativeEmphasis ?? this.enableAffirmativeEmphasis,
    enableContractions: enableContractions ?? this.enableContractions,
    enableSecondContractionToBe: enableSecondContractionToBe ?? this.enableSecondContractionToBe,
    enableModalVerb: enableModalVerb ?? this.enableModalVerb,
    enableDirectObject: enableDirectObject ?? this.enableDirectObject,
    type: type ?? this.type,
    tense: tense ?? this.tense,
    beginningAdverb: beginningAdverb ?? this.beginningAdverb,
    subjectType: subjectType ?? this.subjectType,
    subject: subject ?? this.subject,
    modalVerb: modalVerb ?? this.modalVerb,
    midAdverb: midAdverb ?? this.midAdverb,
    verbType: verbType ?? this.verbType,
    verb: verb ?? this.verb,
    indirectObject: indirectObject ?? this.indirectObject,
    directObject: directObject ?? this.directObject,
    adverbs: adverbs ?? this.adverbs,
    subjectComplement: subjectComplement ?? this.subjectComplement,
  );

  Pronoun? get pronoun => subject is Pronoun? subject as Pronoun : null;
  NounPhrase? get nounPhrase => subject is NounPhrase? subject as NounPhrase : null;

  Verb get validVerb => verb ?? EmptyVerb();
  Verb get verbWord => verb is PhrasalVerb? (verb as PhrasalVerb).verb : validVerb;
  Subject get validSubject => subject ?? EmptySubject();

  String get affirmativeSimplePresent {
    return affirmativeSpeech(
      auxiliarVerbs: [
        enableModalVerb
            ? modalVerb
            : validVerb.isBe
            ? Verb.simplePresentBe(validSubject, enableContractions)
            : enableAffirmativeEmphasis
            ? validSubject.singularThirdPerson
            ? 'does'
            : 'do'
            : null
      ],
      disableSpacePrefixForAuxiliarVerb:
      validVerb.isBe && !enableModalVerb && enableContractions,
      conjugatedVerb: validVerb.isBe && enableModalVerb
          ? verbWord.infinitive
          : verbWord.simplePresent(validSubject),
    );
  }

  String get affirmativeSimplePast {
    return affirmativeSpeech(
      auxiliarVerbs: [
        validVerb.isBe
            ? Verb.simplePastBe(validSubject)
            : enableAffirmativeEmphasis
            ? 'did'
            : null
      ],
      conjugatedVerb:
      enableAffirmativeEmphasis ? verbWord.infinitive : verbWord.simplePast,
    );
  }

  String get affirmativeSimpleFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'ll" : 'will'],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.infinitive);
  }

  String get affirmativeSimplePresentPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions
              ? validSubject.singularThirdPerson
              ? "'s"
              : "'ve"
              : validSubject.singularThirdPerson
              ? 'has'
              : 'have'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get affirmativeSimplePastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d" : "had"],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get affirmativeSimpleFuturePerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions ? "'ll" : 'will',
          validSubject.singularThirdPerson ? 'has' : 'have'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get affirmativeContinuousPresent {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableModalVerb
              ? modalVerb
              : Verb.simplePresentBe(validSubject, enableContractions),
          enableModalVerb ? 'be' : null
        ],
        disableSpacePrefixForAuxiliarVerb:
        !enableModalVerb && enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get affirmativeContinuousPast {
    return affirmativeSpeech(
        auxiliarVerbs: [Verb.simplePastBe(validSubject)],
        conjugatedVerb: verbWord.progressive);
  }

  String get affirmativeContinuousFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'ll" : 'will', 'be'],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get affirmativeContinuousPresentPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions
              ? validSubject.singularThirdPerson
              ? "'s"
              : "'ve"
              : validSubject.singularThirdPerson
              ? 'has'
              : 'have',
          'been'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get affirmativeContinuousPastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d" : "had", 'been'],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get affirmativeContinuousFuturePerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions ? "'ll" : 'will',
          validSubject.singularThirdPerson ? 'has' : 'have',
          'been'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeSimplePresent {
    String simplePresentVerb = verbWord.simplePresent(validSubject);
    return affirmativeSpeech(
      auxiliarVerbs: [
        enableModalVerb
            ? modalVerb?.negative(enableContractions)
            : validVerb.isBe
            ? Verb.negativeSimplePresentBe(
            validSubject, enableContractions, enableSecondContractionToBe)
            : enableContractions
            ? validSubject.singularThirdPerson
            ? "doesn't"
            : "don't"
            : validSubject.singularThirdPerson
            ? 'does not'
            : 'do not'
      ],
      disableSpacePrefixForAuxiliarVerb:
      validVerb.isBe && !enableModalVerb && enableContractions,
      conjugatedVerb: validVerb.isBe && enableModalVerb
          ? verbWord.infinitive
          : simplePresentVerb,
    );
  }

  String get negativeSimplePast {
    return affirmativeSpeech(
      auxiliarVerbs: [
        validVerb.isBe
            ? Verb.negativeSimplePastBe(validSubject, enableContractions)
            : enableContractions
            ? "didn't"
            : 'did not'
      ],
      disableSpacePrefixForAuxiliarVerb: validVerb.isBe && enableContractions,
      conjugatedVerb: verbWord.infinitive,
    );
  }

  String get negativeSimpleFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "won't" : 'will not'],
        conjugatedVerb: verbWord.infinitive);
  }

  String get negativeSimplePresentPerfect {
    return affirmativeSpeech(auxiliarVerbs: [
      enableContractions
          ? validSubject.singularThirdPerson
          ? "hasn't"
          : "haven't"
          : validSubject.singularThirdPerson
          ? 'has not'
          : 'have not'
    ], conjugatedVerb: verbWord.pastParticiple);
  }

  String get negativeSimplePastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d not" : "had not"],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get negativeSimpleFuturePerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions ? "won't" : 'will not',
          validSubject.singularThirdPerson ? 'has' : 'have'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get negativeContinuousPresent {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableModalVerb
              ? modalVerb?.negative(enableContractions)
              : Verb.negativeSimplePresentBe(
              validSubject, enableContractions, enableSecondContractionToBe),
          enableModalVerb ? 'be' : null
        ],
        disableSpacePrefixForAuxiliarVerb: !enableModalVerb &&
            enableContractions &&
            !enableSecondContractionToBe,
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeContinuousPast {
    return affirmativeSpeech(
        auxiliarVerbs: [Verb.negativeSimplePastBe(validSubject, enableContractions)],
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeContinuousFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "won't" : 'will not', 'be'],
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeContinuousPresentPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions
              ? validSubject.singularThirdPerson
              ? "'s not"
              : "'ve not"
              : validSubject.singularThirdPerson
              ? 'has not'
              : 'have not',
          'been'
        ],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeContinuousPastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d not" : "'had not", 'been'],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.progressive);
  }

  String get negativeContinuousFuturePerfect {
    return affirmativeSpeech(auxiliarVerbs: [
      enableContractions ? "won't" : 'will not',
      validSubject.singularThirdPerson ? 'has' : 'have',
      'been'
    ], conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeSimplePresent {
    return affirmativeSpeech(
      interrogative: true,
      auxiliarVerbs: [
        enableModalVerb
            ? modalVerb
            : validVerb.isBe
            ? Verb.simplePresentBe(validSubject, false)
            : validSubject.singularThirdPerson
            ? 'Does'
            : 'Do'
      ],
      conjugatedVerb: verbWord.infinitive,
    );
  }

  String get interrogativeSimplePast {
    return affirmativeSpeech(
      interrogative: true,
      auxiliarVerbs: [validVerb.isBe ? Verb.simplePastBe(validSubject) : 'Did'],
      conjugatedVerb: verbWord.infinitive,
    );
  }

  String get interrogativeSimpleFuture {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ['Will'],
        conjugatedVerb: verbWord.infinitive);
  }

  String get interrogativeSimplePresentPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [validSubject.singularThirdPerson ? 'Has' : 'Have'],
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get interrogativeSimplePastPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ["Had"],
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get interrogativeSimpleFuturePerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ['Will', validSubject.singularThirdPerson ? 'has' : 'have'],
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get interrogativeContinuousPresent {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [
          enableModalVerb ? modalVerb : Verb.simplePresentBe(validSubject, false),
          enableModalVerb ? 'be' : null
        ],
        conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeContinuousPast {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [Verb.simplePastBe(validSubject)],
        conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeContinuousFuture {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ['Will', 'be'],
        conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeContinuousPresentPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [validSubject.singularThirdPerson ? 'Has' : 'Have', 'been'],
        conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeContinuousPastPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ["Had", 'been'],
        conjugatedVerb: verbWord.progressive);
  }

  String get interrogativeContinuousFuturePerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [
          'Will',
          validSubject.singularThirdPerson ? 'has' : 'have',
          'been'
        ],
        conjugatedVerb: verbWord.progressive);
  }

  String affirmativeSpeech({
    bool interrogative = false,
    required List<Object?> auxiliarVerbs,
    bool disableSpacePrefixForAuxiliarVerb = false,
    required String conjugatedVerb,
  }) {
    PhrasalVerbParticle? particle =
    verb is PhrasalVerb? (verb as PhrasalVerb).particle : null;
    Speech speech = Speech();
    speech.add(beginningAdverb);
    speech.add(auxiliarVerbs.first, when: interrogative);
    speech.add(subject);
    speech.add(auxiliarVerbs.first,
        when: !interrogative,
        disablePrefixWhen: disableSpacePrefixForAuxiliarVerb);
    speech.add(midAdverb);
    speech.add(auxiliarVerbs.elementAtOrNull(1));
    speech.add(auxiliarVerbs.elementAtOrNull(2));
    speech.add(conjugatedVerb, when: !validVerb.isBe);
    speech.add(subjectComplement, when: validVerb.isLinkingVerb);
    speech.add(indirectObject, when: !validVerb.isLinkingVerb);
    speech.add(directObject, when: !validVerb.isLinkingVerb);
    speech.add(particle, when: !validVerb.isLinkingVerb);
    speech.add(adverbs.join(' '));
    speech.add('?', when: interrogative, disablePrefixWhen: true);
    return speech.toString();
  }

  @override
  String toString() {
    if (type == ClauseType.affirmative && tense == Tense.simplePresent) {
      return affirmativeSimplePresent;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePast) {
      return affirmativeSimplePast;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuture){
      return affirmativeSimpleFuture;
    } if (type == ClauseType.affirmative && tense == Tense.simplePresentPerfect) {
      return affirmativeSimplePresentPerfect;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePastPerfect) {
      return affirmativeSimplePastPerfect;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuturePerfect){
      return affirmativeSimpleFuturePerfect;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresent) {
      return affirmativeContinuousPresent;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPast) {
      return affirmativeContinuousPast;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuture){
      return affirmativeContinuousFuture;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresentPerfect) {
      return affirmativeContinuousPresentPerfect;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPastPerfect) {
      return affirmativeContinuousPastPerfect;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuturePerfect){
      return affirmativeContinuousFuturePerfect;
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      return negativeSimplePresent;
    } else if (type == ClauseType.negative && tense == Tense.simplePast) {
      return negativeSimplePast;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuture){
      return negativeSimpleFuture;
    } if (type == ClauseType.negative && tense == Tense.simplePresentPerfect) {
      return negativeSimplePresentPerfect;
    } else if (type == ClauseType.negative && tense == Tense.simplePastPerfect) {
      return negativeSimplePastPerfect;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuturePerfect){
      return negativeSimpleFuturePerfect;
    } if (type == ClauseType.negative && tense == Tense.continuousPresent) {
      return negativeContinuousPresent;
    } else if (type == ClauseType.negative && tense == Tense.continuousPast) {
      return negativeContinuousPast;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuture){
      return negativeContinuousFuture;
    } if (type == ClauseType.negative && tense == Tense.continuousPresentPerfect) {
      return negativeContinuousPresentPerfect;
    } else if (type == ClauseType.negative && tense == Tense.continuousPastPerfect) {
      return negativeContinuousPastPerfect;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuturePerfect){
      return negativeContinuousFuturePerfect;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePresent) {
      return interrogativeSimplePresent;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePast) {
      return interrogativeSimplePast;
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuture){
      return interrogativeSimpleFuture;
    } if (type == ClauseType.interrogative && tense == Tense.simplePresentPerfect) {
      return interrogativeSimplePresentPerfect;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePastPerfect) {
      return interrogativeSimplePastPerfect;
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuturePerfect){
      return interrogativeSimpleFuturePerfect;
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresent) {
      return interrogativeContinuousPresent;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPast) {
      return interrogativeContinuousPast;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousFuture){
      return interrogativeContinuousFuture;
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresentPerfect) {
      return interrogativeContinuousPresentPerfect;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPastPerfect) {
      return interrogativeContinuousPastPerfect;
    }
    return interrogativeContinuousFuturePerfect;
  }
}
