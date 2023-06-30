import '../../util/speech.dart';
import '../adverb/adverb.dart';
import '../common/nullable.dart';
import '../noun/direct_object.dart';
import '../noun/empty_subject.dart';
import '../noun/indirect_object.dart';
import '../noun/noun_phrase.dart';
import '../noun/subject.dart';
import '../noun/pronoun.dart';
import '../noun/subject_type.dart';
import '../subject_complement.dart';
import '../tense.dart';
import '../tense_type.dart';
import '../verb/empty_modal_verb.dart';
import '../verb/modal_verb.dart';
import '../verb/empty_verb.dart';
import '../verb/phrasal_verb.dart';
import '../verb/phrasal_verb_particle.dart';
import '../verb/verb.dart';
import '../verb/verb_tense.dart';
import '../verb/verb_word.dart';
import '../verb/verb_phrase.dart';
import 'clause_type.dart';

class IndependentClause {
  bool enableAffirmativeEmphasis;
  bool enableContractions;
  bool enableSecondContractionToBe;
  bool enableModalVerb;
  bool enableDirectObject;
  ClauseType type;
  TenseType tenseType;
  Tense tense;
  Adverb? beginningAdverb;
  SubjectType subjectType;
  Subject? subject;
  ModalVerb? modalVerb;
  Adverb? midAdverb;
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
    required this.tenseType,
    required this.tense,
    this.beginningAdverb,
    this.subjectType = SubjectType.pronoun,
    this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verb,
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
    TenseType? tenseType,
    Tense? tense,
    Nullable<Adverb>? beginningAdverb,
    SubjectType? subjectType,
    Nullable<Subject>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<Adverb>? midAdverb,
    Nullable<Verb>? verb,
    Nullable<IndirectObject>? indirectObject,
    Nullable<DirectObject>? directObject,
    List<Adverb>? adverbs,
    Nullable<SubjectComplement>? subjectComplement,
  }) => IndependentClause(
    enableAffirmativeEmphasis: enableAffirmativeEmphasis ?? this.enableAffirmativeEmphasis,
    enableContractions: enableContractions ?? this.enableContractions,
    enableSecondContractionToBe: enableSecondContractionToBe ?? this.enableSecondContractionToBe,
    enableModalVerb: enableModalVerb ?? this.enableModalVerb,
    enableDirectObject: enableDirectObject ?? this.enableDirectObject,
    type: type ?? this.type,
    tenseType: tenseType ?? this.tenseType,
    tense: tense ?? this.tense,
    beginningAdverb: beginningAdverb == null? this.beginningAdverb : beginningAdverb.value,
    subjectType: subjectType ?? this.subjectType,
    subject: subject == null? this.subject : subject.value,
    modalVerb: modalVerb == null? this.modalVerb : modalVerb.value,
    midAdverb: midAdverb == null? this.midAdverb : midAdverb.value,
    verb: verb == null? this.verb : verb.value,
    indirectObject: indirectObject == null? this.indirectObject : indirectObject.value,
    directObject: directObject == null? this.directObject : directObject.value,
    adverbs: adverbs ?? this.adverbs,
    subjectComplement: subjectComplement == null? this.subjectComplement : subjectComplement.value,
  );

  Pronoun? get pronoun => subject is Pronoun? subject as Pronoun : null;
  NounPhrase? get nounPhrase => subject is NounPhrase? subject as NounPhrase : null;

  Verb get validVerb => verb ?? EmptyVerb();
  ModalVerb get validModalVerb => modalVerb ?? EmptyModalVerb();
  Subject get validSubject => subject ?? EmptySubject();
  Verb get verbWord => verb is PhrasalVerb? (verb as PhrasalVerb).verb : validVerb;

  VerbPhrase get affirmativeSimplePresentVerbPhrase {
    String? firstAuxiliarVerb = enableModalVerb
        ? validModalVerb.value
        : validVerb.isBe
        ? conjugateVerbWord(validVerb)
        : enableAffirmativeEmphasis
        ? validSubject.singularThirdPerson
        ? 'does'
        : 'do'
        : null;
    return VerbPhrase(
      isFirstVerbContracted: validVerb.isBe
          && !enableModalVerb
          && enableContractions,
      auxiliars: [
        if (firstAuxiliarVerb != null) firstAuxiliarVerb
      ],
      conjugatedVerbWord: conjugateVerbWord(verbWord),
      phrasalVerbParticle: validVerb is PhrasalVerb? (validVerb as PhrasalVerb).particle : null,
    );
  }

  VerbTense get verbTense {
    if (type == ClauseType.affirmative) {
      if (tense == Tense.simplePresent) {// He is happy
        return enableModalVerb || (!validVerb.isBe && enableAffirmativeEmphasis)
            ? VerbTense.infinitive
            : VerbTense.present;
      } else if (tense == Tense.simplePast) {
        return !validVerb.isBe && enableAffirmativeEmphasis ? VerbTense.infinitive : VerbTense.past;
      }
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      return enableModalVerb || !validVerb.isBe ? VerbTense.infinitive : VerbTense.present;
    }
    if (tense == Tense.simplePresent) {
      return validVerb.isBe && enableModalVerb? VerbTense.infinitive : VerbTense.present;
    } else if (tense == Tense.simplePast) {
      return VerbTense.infinitive;
    } else if (tense == Tense.simpleFuture) {
      return VerbTense.infinitive;
    } else if (tense == Tense.simplePresentPerfect
        || tense == Tense.simplePastPerfect
        || tense == Tense.simpleFuturePerfect) {
      return VerbTense.pastParticiple;
    } else {
      return VerbTense.presentParticiple;
    }
  }

  VerbPhrase get affirmativeSimplePastVerbPhrase {
    String? firstAuxiliar = validVerb.isBe
        ? simplePastVerb(validVerb)
        : enableAffirmativeEmphasis
        ? 'did'
        : null;
    return VerbPhrase(
      isFirstVerbContracted: false,
      auxiliars: [
        if (firstAuxiliar !=null) firstAuxiliar
      ],
      conjugatedVerbWord: conjugateVerbWord(verbWord),
    );
  }

  String simplePastVerb(Verb verb) {
    if (verb.isBe) {
      if(type == ClauseType.negative) {
        Verb.negativeSimplePastBe(validSubject, enableContractions);
      }
      Verb.simplePastBe(validSubject);
    }
    return verb.past;
  }

  VerbPhrase get affirmativeSimpleFutureVerbPhrase => VerbPhrase(
    isFirstVerbContracted: enableContractions,
    auxiliars: [enableContractions ? "'ll" : 'will'],
    conjugatedVerbWord: verbWord.infinitive,
  );

  VerbPhrase get affirmativeSimplePresentPerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [
        enableContractions
            ? validSubject.singularThirdPerson
            ? "'s"
            : "'ve"
            : validSubject.singularThirdPerson
            ? 'has'
            : 'have'
      ],
      conjugatedVerbWord: verbWord.pastParticiple
  );

  VerbPhrase get affirmativeSimplePastPerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [enableContractions ? "'d" : "had"],
      conjugatedVerbWord: verbWord.pastParticiple
  );

  VerbPhrase get affirmativeSimpleFuturePerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [
        enableContractions ? "'ll" : 'will',
        'have'
      ],
      conjugatedVerbWord: verbWord.pastParticiple
  );

  VerbPhrase get affirmativeContinuousPresentVerbPhrase => VerbPhrase(
      isFirstVerbContracted: !enableModalVerb && enableContractions,
      auxiliars: [
        enableModalVerb
            ? validModalVerb.value
            : Verb.simplePresentBe(validSubject, enableContractions),
        if (enableModalVerb && verbWord.isBe) 'be'
      ],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get affirmativeContinuousPastVerbPhrase => VerbPhrase(
      isFirstVerbContracted: false,
      auxiliars: [Verb.simplePastBe(validSubject)],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get affirmativeContinuousFutureVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [enableContractions ? "'ll" : 'will', 'be'],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get affirmativeContinuousPresentPerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [
        enableContractions
            ? validSubject.singularThirdPerson
            ? "'s"
            : "'ve"
            : validSubject.singularThirdPerson
            ? 'has'
            : 'have',
        'been'
      ],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get affirmativeContinuousPastPerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [enableContractions ? "'d" : "had", 'been'],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get affirmativeContinuousFuturePerfectVerbPhrase => VerbPhrase(
      isFirstVerbContracted: enableContractions,
      auxiliars: [
        enableContractions ? "'ll" : 'will',
        'have',
        'been'
      ],
      conjugatedVerbWord: verbWord.presentParticiple
  );

  VerbPhrase get negativeSimplePresentVerbPhrase {
    String simplePresentVerb = verbWord.present(validSubject);
    return VerbPhrase(
      isFirstVerbContracted: validVerb.isBe && !enableModalVerb && enableContractions,
      auxiliars: [
        enableModalVerb
            ? validModalVerb.negative(enableContractions)
            : validVerb.isBe
            ? conjugateVerbWord(verbWord)
            : enableContractions
            ? validSubject.singularThirdPerson
            ? "doesn't"
            : "don't"
            : validSubject.singularThirdPerson
            ? 'does not'
            : 'do not'
      ],
      conjugatedVerbWord: conjugateVerbWord(verbWord),
    );
  }

  VerbPhrase get negativeSimplePastVerbPhrase {
    return VerbPhrase(
      isFirstVerbContracted: validVerb.isBe && enableContractions,
      auxiliars: [
        validVerb.isBe
            ? Verb.negativeSimplePastBe(validSubject, enableContractions)
            : enableContractions
            ? "didn't"
            : 'did not'
      ],
      conjugatedVerbWord: verbWord.infinitive,
    );
  }

  VerbPhrase get negativeSimpleFutureVerbPhrase {
    return VerbPhrase(
        auxiliars: [enableContractions ? "won't" : 'will not'],
        conjugatedVerbWord: verbWord.infinitive
    );
  }

  VerbPhrase get negativeSimplePresentPerfectVerbPhrase {
    return VerbPhrase(
      auxiliars: [
        enableContractions
            ? validSubject.singularThirdPerson
            ? "hasn't"
            : "haven't"
            : validSubject.singularThirdPerson
            ? 'has not'
            : 'have not'
      ],
      conjugatedVerbWord: verbWord.pastParticiple
    );
  }

  VerbPhrase get negativeSimplePastPerfectVerbPhrase {
    return VerbPhrase(
        isFirstVerbContracted: !enableContractions,
        auxiliars: [enableContractions ? "'d not" : "had not"],
        conjugatedVerbWord: verbWord.pastParticiple);
  }

  VerbPhrase get negativeSimpleFuturePerfectVerbPhrase {
    return VerbPhrase(
        isFirstVerbContracted: !enableContractions,
        auxiliars: [
          enableContractions ? "won't" : 'will not',
          validSubject.singularThirdPerson ? 'has' : 'have'
        ],
        conjugatedVerbWord: verbWord.pastParticiple);
  }

  VerbPhrase get negativeContinuousPresentVerbPhrase {
    return VerbPhrase(
        isFirstVerbContracted: !enableModalVerb &&
            enableContractions &&
            !enableSecondContractionToBe,
        auxiliars: [
          enableModalVerb
              ? validModalVerb.negative(enableContractions)
              : Verb.negativeSimplePresentBe(
              validSubject, enableContractions, enableSecondContractionToBe),
          if (enableModalVerb) 'be'
        ],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get negativeContinuousPastVerbPhrase {
    return VerbPhrase(
        auxiliars: [Verb.negativeSimplePastBe(validSubject, enableContractions)],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get negativeContinuousFutureVerbPhrase {
    return VerbPhrase(
        auxiliars: [enableContractions ? "won't" : 'will not', 'be'],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get negativeContinuousPresentPerfectVerbPhrase {
    return VerbPhrase(
        isFirstVerbContracted: !enableContractions,
        auxiliars: [
          enableContractions
              ? validSubject.singularThirdPerson
              ? "'s not"
              : "'ve not"
              : validSubject.singularThirdPerson
              ? 'has not'
              : 'have not',
          'been'
        ],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get negativeContinuousPastPerfectVerbPhrase {
    return VerbPhrase(
        isFirstVerbContracted: !enableContractions,
        auxiliars: [enableContractions ? "'d not" : "'had not", 'been'],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get negativeContinuousFuturePerfectVerbPhrase {
    return VerbPhrase(
      auxiliars: [
        enableContractions ? "won't" : 'will not',
        validSubject.singularThirdPerson ? 'has' : 'have',
        'been'
      ],
      conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeSimplePresentVerbPhrase {
    return VerbPhrase(
      invertAuxiliarAndSubject: true,
      auxiliars: [
        enableModalVerb
            ? validModalVerb.value
            : validVerb.isBe
            ? Verb.simplePresentBe(validSubject, false)
            : validSubject.singularThirdPerson
            ? 'Does'
            : 'Do'
      ],
      conjugatedVerbWord: verbWord.infinitive,
    );
  }

  VerbPhrase get interrogativeSimplePastVerbPhrase {
    return VerbPhrase(
      invertAuxiliarAndSubject: true,
      auxiliars: [validVerb.isBe ? Verb.simplePastBe(validSubject) : 'Did'],
      conjugatedVerbWord: verbWord.infinitive,
    );
  }

  VerbPhrase get interrogativeSimpleFutureVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: ['Will'],
        conjugatedVerbWord: verbWord.infinitive);
  }

  VerbPhrase get interrogativeSimplePresentPerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: [validSubject.singularThirdPerson ? 'Has' : 'Have'],
        conjugatedVerbWord: verbWord.pastParticiple);
  }

  VerbPhrase get interrogativeSimplePastPerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: ["Had"],
        conjugatedVerbWord: verbWord.pastParticiple);
  }

  VerbPhrase get interrogativeSimpleFuturePerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: ['Will', validSubject.singularThirdPerson ? 'has' : 'have'],
        conjugatedVerbWord: verbWord.pastParticiple);
  }

  VerbPhrase get interrogativeContinuousPresentVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: [
          enableModalVerb ? validModalVerb.value : Verb.simplePresentBe(validSubject, false),
          if (enableModalVerb) 'be'
        ],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeContinuousPastVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: [Verb.simplePastBe(validSubject)],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeContinuousFutureVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: ['Will', 'be'],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeContinuousPresentPerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: [validSubject.singularThirdPerson ? 'Has' : 'Have', 'been'],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeContinuousPastPerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: ["Had", 'been'],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

  VerbPhrase get interrogativeContinuousFuturePerfectVerbPhrase {
    return VerbPhrase(
        invertAuxiliarAndSubject: true,
        auxiliars: [
          'Will',
          validSubject.singularThirdPerson ? 'has' : 'have',
          'been'
        ],
        conjugatedVerbWord: verbWord.presentParticiple);
  }

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
      conjugatedVerb: validVerb.isBe && enableModalVerb || enableAffirmativeEmphasis
          ? verbWord.infinitive
          : verbWord.present(validSubject),
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
      enableAffirmativeEmphasis ? verbWord.infinitive : verbWord.past,
    );
  }

  String get affirmativeSimpleFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'ll" : 'will'],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
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
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get affirmativeSimplePastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d" : "had"],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.pastParticiple);
  }

  String get affirmativeSimpleFuturePerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions ? "'ll" : 'will',
          'have'
        ],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
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
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get affirmativeContinuousPast {
    return affirmativeSpeech(
        auxiliarVerbs: [Verb.simplePastBe(validSubject)],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get affirmativeContinuousFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'ll" : 'will', 'be'],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.presentParticiple);
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
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get affirmativeContinuousPastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d" : "had", 'been'],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get affirmativeContinuousFuturePerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [
          enableContractions ? "'ll" : 'will',
          validSubject.singularThirdPerson ? 'has' : 'have',
          'been'
        ],
        disableSpacePrefixForAuxiliarVerb: enableContractions,
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get negativeSimplePresent {
    String simplePresentVerb = verbWord.present(validSubject);
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
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get negativeContinuousPast {
    return affirmativeSpeech(
        auxiliarVerbs: [Verb.negativeSimplePastBe(validSubject, enableContractions)],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get negativeContinuousFuture {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "won't" : 'will not', 'be'],
        conjugatedVerb: verbWord.presentParticiple);
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
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get negativeContinuousPastPerfect {
    return affirmativeSpeech(
        auxiliarVerbs: [enableContractions ? "'d not" : "'had not", 'been'],
        disableSpacePrefixForAuxiliarVerb: !enableContractions,
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get negativeContinuousFuturePerfect {
    return affirmativeSpeech(auxiliarVerbs: [
      enableContractions ? "won't" : 'will not',
      validSubject.singularThirdPerson ? 'has' : 'have',
      'been'
    ], conjugatedVerb: verbWord.presentParticiple);
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
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get interrogativeContinuousPast {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [Verb.simplePastBe(validSubject)],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get interrogativeContinuousFuture {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ['Will', 'be'],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get interrogativeContinuousPresentPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [validSubject.singularThirdPerson ? 'Has' : 'Have', 'been'],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get interrogativeContinuousPastPerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: ["Had", 'been'],
        conjugatedVerb: verbWord.presentParticiple);
  }

  String get interrogativeContinuousFuturePerfect {
    return affirmativeSpeech(
        interrogative: true,
        auxiliarVerbs: [
          'Will',
          validSubject.singularThirdPerson ? 'has' : 'have',
          'been'
        ],
        conjugatedVerb: verbWord.presentParticiple);
  }
  
  bool get isFirstAuxiliarVerbContracted { return true; }
  String? get frontAdverbString { return beginningAdverb == null? '<Front Adverb>' : '$beginningAdverb'; }
  String get subjectString { return '$validSubject'; }
  String? get firstAuxiliarVerb { return null; }
  String? get midAdverbString { return ''; }
  String? get secondAuxiliarVerb { return ''; }
  String? get thirdAuxiliarVerb { return ''; }
  String get conjugatedVerbWord { return ''; }
  String get subjectComplementString { return subjectComplement == null? '<Subject Complement>' : '$subjectComplement'; }
  String get indirectObjectString { return indirectObject == null? '<Indirect Object>' : '$indirectObject'; }
  String get directObjectString { return directObject == null? '<Direct Object>' : '$directObject'; }
  String? get phrasalVerbParticle { return verb is PhrasalVerb? (verb as PhrasalVerb).particle.toString() : null; }
  List<String>? get adverbStrings { return null; }
  
  String conjugateVerbWord(Verb verb) {
    if (verbTense == VerbTense.present) {
      return verb.present(validSubject, enableContractions, type == ClauseType.negative, enableSecondContractionToBe);
    } if (verbTense == VerbTense.past) {
      return simplePastVerb(verb);
    } else if (verbTense == VerbTense.presentParticiple) {
      return verb.presentParticiple;
    } else if (verbTense == VerbTense.pastParticiple) {
      return verb.pastParticiple;
    }
    return verb.infinitive;
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
    speech.add(validSubject);
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

  String speech(VerbPhrase verbPhrase) {
    PhrasalVerbParticle? particle =
    verb is PhrasalVerb? (verb as PhrasalVerb).particle : null;
    Speech speech = Speech();
    speech.add(beginningAdverb);
    speech.add(verbPhrase.firstAuxiliar, when: verbPhrase.invertAuxiliarAndSubject);
    speech.add(validSubject);
    speech.add(verbPhrase.firstAuxiliar,
        when: !verbPhrase.invertAuxiliarAndSubject,
        disablePrefixWhen: verbPhrase.isFirstVerbContracted);
    speech.add(midAdverb);
    speech.add(verbPhrase.secondAuxiliar);
    speech.add(verbPhrase.thirdAuxiliar);
    speech.add(verbPhrase.conjugatedVerbWord, when: !validVerb.isBe);
    speech.add(subjectComplement, when: validVerb.isLinkingVerb);
    speech.add(indirectObject, when: !validVerb.isLinkingVerb);
    speech.add(directObject, when: !validVerb.isLinkingVerb);
    speech.add(particle, when: !validVerb.isLinkingVerb);
    speech.add(adverbs.join(' '));
    speech.add('?', when: verbPhrase.invertAuxiliarAndSubject, disablePrefixWhen: true);
    return speech.toString();
  }

  @override
  String toString() {
    if (type == ClauseType.affirmative && tense == Tense.simplePresent) {
      // return affirmativeSimplePresent;
      return speech(affirmativeSimplePresentVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.simplePast) {
      // return affirmativeSimplePast;
      return speech(affirmativeSimplePastVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuture){
      // return affirmativeSimpleFuture;
      return speech(affirmativeSimpleFutureVerbPhrase);
    } if (type == ClauseType.affirmative && tense == Tense.simplePresentPerfect) {
      // return affirmativeSimplePresentPerfect;
      return speech(affirmativeSimplePresentPerfectVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.simplePastPerfect) {
      // return affirmativeSimplePastPerfect;
      return speech(affirmativeSimplePastPerfectVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuturePerfect){
      // return affirmativeSimpleFuturePerfect;
      return speech(affirmativeSimpleFuturePerfectVerbPhrase);
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresent) {
      // return affirmativeContinuousPresent;
      return speech(affirmativeContinuousPresentVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPast) {
      // return affirmativeContinuousPast;
      return speech(affirmativeContinuousPastVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuture){
      // return affirmativeContinuousFuture;
      return speech(affirmativeContinuousFutureVerbPhrase);
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresentPerfect) {
      // return affirmativeContinuousPresentPerfect;
      return speech(affirmativeContinuousPresentPerfectVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPastPerfect) {
      // return affirmativeContinuousPastPerfect;
      return speech(affirmativeContinuousPastPerfectVerbPhrase);
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuturePerfect){
      // return affirmativeContinuousFuturePerfect;
      return speech(affirmativeContinuousFuturePerfectVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      // return negativeSimplePresent;
      return speech(negativeSimplePresentVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.simplePast) {
      // return negativeSimplePast;
      return speech(negativeSimplePastVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.simpleFuture){
      // return negativeSimpleFuture;
      return speech(negativeSimpleFutureVerbPhrase);
    } if (type == ClauseType.negative && tense == Tense.simplePresentPerfect) {
      // return negativeSimplePresentPerfect;
      return speech(negativeSimplePresentPerfectVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.simplePastPerfect) {
      // return negativeSimplePastPerfect;
      return speech(negativeSimplePastPerfectVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.simpleFuturePerfect){
      // return negativeSimpleFuturePerfect;
      return speech(negativeSimpleFuturePerfectVerbPhrase);
    } if (type == ClauseType.negative && tense == Tense.continuousPresent) {
      // return negativeContinuousPresent;
      return speech(negativeContinuousPresentVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.continuousPast) {
      // return negativeContinuousPast;
      return speech(negativeContinuousPastVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.continuousFuture){
      // return negativeContinuousFuture;
      return speech(negativeContinuousFutureVerbPhrase);
    } if (type == ClauseType.negative && tense == Tense.continuousPresentPerfect) {
      // return negativeContinuousPresentPerfect;
      return speech(negativeContinuousPresentPerfectVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.continuousPastPerfect) {
      // return negativeContinuousPastPerfect;
      return speech(negativeContinuousPastPerfectVerbPhrase);
    } else if (type == ClauseType.negative && tense == Tense.continuousFuturePerfect){
      // return negativeContinuousFuturePerfect;
      return speech(negativeContinuousFuturePerfectVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.simplePresent) {
      // return interrogativeSimplePresent;
      return speech(interrogativeSimplePresentVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.simplePast) {
      // return interrogativeSimplePast;
      return speech(interrogativeSimplePastVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuture){
      // return interrogativeSimpleFuture;
      return speech(interrogativeSimpleFutureVerbPhrase);
    } if (type == ClauseType.interrogative && tense == Tense.simplePresentPerfect) {
      // return interrogativeSimplePresentPerfect;
      return speech(interrogativeSimplePresentPerfectVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.simplePastPerfect) {
      // return interrogativeSimplePastPerfect;
      return speech(interrogativeSimplePastPerfectVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuturePerfect){
      // return interrogativeSimpleFuturePerfect;
      return speech(interrogativeSimpleFuturePerfectVerbPhrase);
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresent) {
      // return interrogativeContinuousPresent;
      return speech(interrogativeContinuousPresentVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPast) {
      // return interrogativeContinuousPast;
      return speech(interrogativeContinuousPastVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.continuousFuture){
      // return interrogativeContinuousFuture;
      return speech(interrogativeContinuousFutureVerbPhrase);
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresentPerfect) {
      // return interrogativeContinuousPresentPerfect;
      return speech(interrogativeContinuousPresentPerfectVerbPhrase);
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPastPerfect) {
      // return interrogativeContinuousPastPerfect;
      return speech(interrogativeContinuousPastPerfectVerbPhrase);
    }
    // return interrogativeContinuousFuturePerfect;
    return speech(interrogativeContinuousFuturePerfectVerbPhrase);
  }
}
