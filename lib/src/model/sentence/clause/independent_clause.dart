import '../../../util/util.dart';
import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/subject_complement.dart';
import '../verb/any_verb.dart';
import '../verb/auxiliary_verbs.dart';
import '../verb/be.dart';
import '../verb/modal_verb.dart';
import '../verb/phrasal-verb.dart';
import '../verb/value/verb_tense.dart';
import '../verb/verb.dart';
import 'value/clause_type.dart';
import 'value/tense.dart';

class IndependentClause {
  final String frontAdverbPlaceholder = '<FrontAdverb>';
  final String subjectPlaceholder = '<Subject>';
  final String midAdverbPlaceholder = '<MidAdverb>';
  final String firstAuxiliaryVerbPlaceholder = '<FirstAuxiliaryVerb>';
  final String secondAuxiliaryVerbPlaceholder = '<SecondAuxiliaryVerb>';
  final String thirdAuxiliaryVerbPlaceholder = '<ThirdAuxiliaryVerb>';
  final String indirectObjectPlaceholder = '<IndirectObject>';
  final String directObjectPlaceholder = '<DirectObject>';
  final String subjectComplementPlaceholder = '<SubjectComplement>';
  final String endAdverbPlaceholder = '<EndAdverb>';
  final String frontAdverbPlaceholderEs = '<AdverbioFrontal>';
  final String subjectPlaceholderEs = '<Sujeto>';
  final String midAdverbPlaceholderEs = '<AdverbioIntermedio>';
  final String firstAuxiliaryVerbPlaceholderEs = '<PrimerVerboAuxiliar>';
  final String secondAuxiliaryVerbPlaceholderEs = '<SegundoVerboAuxiliar>';
  final String thirdAuxiliaryVerbPlaceholderEs = '<TercerVerboAuxiliar>';
  final String indirectObjectPlaceholderEs = '<ObjetoIndirecto>';
  final String directObjectPlaceholderEs = '<ObjetoDirecto>';
  final String subjectComplementPlaceholderEs = '<ComplementoDelSujeto>';
  final String endAdverbPlaceholderEs = '<AdverbioFinal>';

  final bool isModalVerbEnabled;
  final bool isAffirmativeEmphasisEnabled;
  final bool isVerbContractionEnabled;
  final bool isNegativeContractionEnabled;
  final ClauseType clauseType;
  final Tense tense;
  final AnyAdverb? frontAdverb;
  final AnyNoun? subject;
  final ModalVerb? modalVerb;
  final AnyAdverb? midAdverb;
  final AnyVerb? verb;
  final AnyNoun? indirectObject;
  final AnyNoun? directObject;
  final SubjectComplement? subjectComplement;
  final AnyAdverb? endAdverb;

  bool get isAffirmative => clauseType == ClauseType.affirmative;
  bool get isNegative => clauseType == ClauseType.negative;
  bool get isInterrogative => clauseType == ClauseType.interrogative;

  bool get isSimplePresent => tense == Tense.simplePresent;
  bool get isSimplePast => tense == Tense.simplePast;
  bool get isSimpleFuture => tense == Tense.simpleFuture;
  bool get isSimplePresentPerfect => tense == Tense.simplePresentPerfect;
  bool get isSimplePastPerfect => tense == Tense.simplePastPerfect;
  bool get isSimpleFuturePerfect => tense == Tense.simpleFuturePerfect;

  bool get isContinuousPresent => tense == Tense.continuousPresent;
  bool get isContinuousPast => tense == Tense.continuousPast;
  bool get isContinuousFuture => tense == Tense.continuousFuture;
  bool get isContinuousPresentPerfect =>
      tense == Tense.continuousPresentPerfect;
  bool get isContinuousPastPerfect => tense == Tense.continuousPastPerfect;
  bool get isContinuousFuturePerfect => tense == Tense.continuousFuturePerfect;

  bool get hasSingularFirstPersonSubject =>
      subject?.isSingularFirstPerson ?? true;
  bool get hasSingularThirdPersonSubject =>
      subject?.isSingularThirdPerson ?? false;
  bool get hasPluralSubject => subject?.isPlural ?? false;
  PersonalPronoun get subjectAsPronoun =>
      subject?.asPronoun ?? PersonalPronoun.I;

  bool get isWouldModalVerb => modalVerb?.isWould ?? false;

  bool get hasTransitiveVerb => verb?.isTransitive ?? false;
  bool get hasDitransitiveVerb => verb?.isDitransitive ?? false;
  bool get hasLinkingVerb => verb?.isLinkingVerb ?? false;

  String get modalVerbPlaceholder => isNegative
      ? isVerbContractionEnabled
          ? '<NegativeModalSubjectContraction>'
          : isNegativeContractionEnabled
              ? '<NegativeModalNegativeContraction>'
              : '<NegativeModalVerb>'
      : !isInterrogative && isVerbContractionEnabled
          ? '<ModalVerbSubjectContraction>'
          : '<ModalVerb>';

  String get verbPlaceholder => switch (verbTense) {
        VerbTense.infinitive => '<BareInfinitiveVerb>',
        VerbTense.present => '<SimplePresentVerb>',
        VerbTense.past => '<PastVerb>',
        VerbTense.future => '<FutureVerb>',
        VerbTense.progressive => '<ProgressiveVerb>',
        VerbTense.pastParticiple => '<PastParticipleVerb>',
        VerbTense.conditional => '<Conditional>',
      };

  bool get isVerbContractionActive {
    final hasContractedModalVerb = modalVerb?.hasVerbContraction ?? false;
    return switch (tense) {
      Tense.simplePresent || Tense.continuousPresent => !isInterrogative &&
          isVerbContractionEnabled &&
          (isModalVerbEnabled && hasContractedModalVerb || isBeAuxiliary),
      Tense.simplePast || Tense.continuousPast => false,
      _ => !isInterrogative && isVerbContractionEnabled,
    };
  }

  bool get isBeAuxiliary => switch (tense) {
        Tense.simplePresent => !isModalVerbEnabled && verb is Be,
        Tense.simplePast => verb is Be,
        _ => false,
      };

  String get firstAuxiliaryVerbDescription => [
        if (isModalVerbEnabled) 'Modal Verb',
        if (isAffirmativeEmphasisEnabled) 'Affirmative Emphasis',
        if (isVerbContractionEnabled) 'Verb Contraction',
        if (isNegativeContractionEnabled) 'Negative Contraction',
      ].join(', ');

  AuxiliaryVerbs get auxiliaryVerbs => switch (tense) {
        Tense.simplePresent => _simplePresent,
        Tense.simplePast => _simplePast,
        Tense.simpleFuture => _simpleFuture,
        Tense.simplePresentPerfect => _simplePresentPerfect,
        Tense.simplePastPerfect => _simplePastPerfect,
        Tense.simpleFuturePerfect => _simpleFuturePerfect,
        Tense.continuousPresent => _continuousPresent,
        Tense.continuousPast => _continuousPast,
        Tense.continuousFuture => _continuousFuture,
        Tense.continuousPresentPerfect => _continuousPresentPerfect,
        Tense.continuousPastPerfect => _continuousPastPerfect,
        Tense.continuousFuturePerfect => _continuousFuturePerfect,
      };

  AuxiliaryVerbs get _simplePresent => AuxiliaryVerbs(
        first: isNegative
            ? isModalVerbEnabled
                ? modalVerbAsString()
                : verb is Be
                    ? _presentBe
                    : isNegativeContractionEnabled
                        ? (hasSingularThirdPersonSubject ? "doesn't" : "don't")
                        : hasSingularThirdPersonSubject
                            ? 'does not'
                            : 'do not'
            : isModalVerbEnabled
                ? modalVerbAsString()
                : verb is Be
                    ? _presentBe
                    : isInterrogative || isAffirmativeEmphasisEnabled
                        ? (hasSingularThirdPersonSubject ? 'does' : 'do')
                        : null,
      );

  AuxiliaryVerbs get _simplePast => AuxiliaryVerbs(
      first: isNegative
          ? verb is Be
              ? _pastBe
              : (isNegativeContractionEnabled ? "didn't" : 'did not')
          : verb is Be
              ? _pastBe
              : isInterrogative || isAffirmativeEmphasisEnabled
                  ? 'did'
                  : null);

  AuxiliaryVerbs get _simpleFuture => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? "'ll not"
              : (isNegativeContractionEnabled ? "won't" : 'will not')
          : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'));

  AuxiliaryVerbs get _simplePresentPerfect => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? (hasSingularThirdPersonSubject ? "'s not" : "'ve not")
              : isNegativeContractionEnabled
                  ? (hasSingularThirdPersonSubject ? "hasn't" : "haven't")
                  : (hasSingularThirdPersonSubject ? 'has not' : 'have not')
          : isAffirmative && isVerbContractionEnabled
              ? (hasSingularThirdPersonSubject ? "'s" : "'ve")
              : (hasSingularThirdPersonSubject ? 'has' : 'have'));

  AuxiliaryVerbs get _simplePastPerfect => AuxiliaryVerbs(
      first: isNegative
          ? (isVerbContractionEnabled ? "'d not" : "had not")
          : (isAffirmative && isVerbContractionEnabled ? "'d" : "had"));

  AuxiliaryVerbs get _simpleFuturePerfect => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? "'ll not"
              : (isNegativeContractionEnabled ? "won't" : 'will not')
          : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
      second: 'have');

  AuxiliaryVerbs get _continuousPresent => AuxiliaryVerbs(
      first: isModalVerbEnabled ? modalVerbAsString() : _presentBe,
      second: isModalVerbEnabled ? 'be' : null);

  AuxiliaryVerbs get _continuousPast => AuxiliaryVerbs(first: _pastBe);

  AuxiliaryVerbs get _continuousFuture => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? "'ll not"
              : (isNegativeContractionEnabled ? "won't" : 'will not')
          : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
      second: 'be');

  AuxiliaryVerbs get _continuousPresentPerfect => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? (hasSingularThirdPersonSubject ? "'s not" : "'ve not")
              : isNegativeContractionEnabled
                  ? (hasSingularThirdPersonSubject ? "hasn't" : "haven't")
                  : (hasSingularThirdPersonSubject ? 'has not' : 'have not')
          : isAffirmative && isVerbContractionEnabled
              ? (hasSingularThirdPersonSubject ? "'s" : "'ve")
              : (hasSingularThirdPersonSubject ? 'has' : 'have'),
      second: 'been');

  AuxiliaryVerbs get _continuousPastPerfect => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? "'d not"
              : (isNegativeContractionEnabled ? "hadn't" : "had not")
          : (isAffirmative && isVerbContractionEnabled ? "'d" : "had"),
      second: 'been');

  AuxiliaryVerbs get _continuousFuturePerfect => AuxiliaryVerbs(
      first: isNegative
          ? isVerbContractionEnabled
              ? "'ll not"
              : (isNegativeContractionEnabled ? "won't" : 'will not')
          : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
      second: 'have',
      third: 'been');

  VerbTense get verbTense => isSimplePresent
      ? isAffirmative && !isAffirmativeEmphasisEnabled && !isModalVerbEnabled
          ? VerbTense.present
          : VerbTense.infinitive
      : isSimplePast
          ? isAffirmative && !isAffirmativeEmphasisEnabled
              ? VerbTense.past
              : VerbTense.infinitive
          : isSimpleFuture
              ? VerbTense.infinitive
              : isSimplePresentPerfect ||
                      isSimplePastPerfect ||
                      isSimpleFuturePerfect
                  ? VerbTense.pastParticiple
                  : VerbTense.progressive;

  String get _presentBe => isNegative
      ? hasSingularFirstPersonSubject
          ? (isVerbContractionEnabled ? "'m not" : 'am not')
          : hasSingularThirdPersonSubject
              ? isVerbContractionEnabled
                  ? "'s not"
                  : (isNegativeContractionEnabled ? "isn't" : 'is not')
              : isVerbContractionEnabled
                  ? "'re not"
                  : (isNegativeContractionEnabled ? "aren't" : 'are not')
      : hasSingularFirstPersonSubject
          ? (isAffirmative && isVerbContractionEnabled ? "'m" : 'am')
          : hasSingularThirdPersonSubject
              ? (isAffirmative && isVerbContractionEnabled ? "'s" : 'is')
              : (isAffirmative && isVerbContractionEnabled ? "'re" : 'are');

  String get _pastBe => isNegative
      ? isNegativeContractionEnabled
          ? (hasPluralSubject ? "weren't" : "wasn't")
          : (hasPluralSubject ? 'were not' : 'was not')
      : (hasPluralSubject ? 'were' : 'was');

  String get modalVerbPlaceholderEs => isNegative
      ? isVerbContractionEnabled
          ? '<ModalNegativoComoContracciónDelSujeto>'
          : isNegativeContractionEnabled
              ? '<VerboModalNegativoComoContracciónNegativa>'
              : '<VerboModalNegativo>'
      : !isInterrogative && isVerbContractionEnabled
          ? '<VerboModalComoContracciónDelSujeto>'
          : '<VerboModal>';

  String get verbPlaceholderEs => switch (verbTense) {
        VerbTense.infinitive => '<VerboInfinitivoSuelto>',
        VerbTense.present => '<VerboPresenteSimple>',
        VerbTense.past => '<VerboPasado>',
        VerbTense.future => '<VerboFuturo>',
        VerbTense.progressive => '<VerboProgresivo>',
        VerbTense.pastParticiple => '<VerboPasadoParticipio>',
        VerbTense.conditional => '<VerboCondicional>',
      };

  AuxiliaryVerbs get auxiliaryVerbsEs => switch (tense) {
        Tense.simplePresent => _simplePresentEs,
        Tense.simplePast => _simplePastEs,
        Tense.simpleFuture => _simpleFutureEs,
        Tense.simplePresentPerfect => _simplePresentPerfectEs,
        Tense.simplePastPerfect => _simplePastPerfectEs,
        Tense.simpleFuturePerfect => _simpleFuturePerfectEs,
        Tense.continuousPresent => _continuousPresentEs,
        Tense.continuousPast => _continuousPastEs,
        Tense.continuousFuture => _continuousFutureEs,
        Tense.continuousPresentPerfect => _continuousPresentPerfectEs,
        Tense.continuousPastPerfect => _continuousPastPerfectEs,
        Tense.continuousFuturePerfect => _continuousFuturePerfectEs,
      };

  AuxiliaryVerbs get _simplePresentEs => AuxiliaryVerbs(
      first: isModalVerbEnabled
          ? modalVerbAsStringEs()
          : verb is Be
              ? _presentBeEs
              : isNegative
                  ? 'no'
                  : '');

  AuxiliaryVerbs get _simplePastEs => AuxiliaryVerbs(
      first: verb is Be
          ? _pastBeEs
          : isNegative
              ? 'no'
              : '');

  AuxiliaryVerbs get _simpleFutureEs =>
      AuxiliaryVerbs(first: isNegative ? "no" : '');

  AuxiliaryVerbs get _simplePresentPerfectEs =>
      AuxiliaryVerbs(first: _presentHaveEs);

  AuxiliaryVerbs get _simplePastPerfectEs => AuxiliaryVerbs(first: _pastHaveEs);

  AuxiliaryVerbs get _simpleFuturePerfectEs =>
      AuxiliaryVerbs(first: '', second: _futureHaveEs);

  AuxiliaryVerbs get _continuousPresentEs => AuxiliaryVerbs(
      first: isModalVerbEnabled ? modalVerbAsStringEs() : _presentBeAsEstarEs,
      second: isModalVerbEnabled ? 'estar' : null);

  AuxiliaryVerbs get _continuousPastEs =>
      AuxiliaryVerbs(first: _pastBeAsEstarEs);

  AuxiliaryVerbs get _continuousFutureEs => AuxiliaryVerbs(
      first: isNegative ? 'no' : '',
      second: switch (subjectAsPronoun) {
        PersonalPronoun.I => 'estaré',
        PersonalPronoun.you => 'estarás/estarán',
        PersonalPronoun.we => 'estaremos',
        PersonalPronoun.they => 'estarán',
        PersonalPronoun.he ||
        PersonalPronoun.she ||
        PersonalPronoun.it =>
          'estará',
      });

  AuxiliaryVerbs get _continuousPresentPerfectEs =>
      AuxiliaryVerbs(first: _presentHaveEs, second: 'estado');

  AuxiliaryVerbs get _continuousPastPerfectEs =>
      AuxiliaryVerbs(first: _pastHaveEs, second: 'estado');

  AuxiliaryVerbs get _continuousFuturePerfectEs => AuxiliaryVerbs(
        first: isNegative ? 'no' : '',
        second: _futureHaveEs,
        third: 'estado',
      );

  VerbTense get verbTenseEs => isSimplePresent
      ? isModalVerbEnabled
          ? (isWouldModalVerb ? VerbTense.conditional : VerbTense.infinitive)
          : VerbTense.present
      : isSimplePast
          ? VerbTense.past
          : isSimpleFuture
              ? VerbTense.future
              : isSimplePresentPerfect ||
                      isSimplePastPerfect ||
                      isSimpleFuturePerfect
                  ? VerbTense.pastParticiple
                  : VerbTense.progressive;

  String get _presentBeEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'soy',
      PersonalPronoun.you => 'eres/son',
      PersonalPronoun.we => 'somos',
      PersonalPronoun.they => 'son',
      _ => 'es',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _pastBeEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'fui',
      PersonalPronoun.you => 'fuiste/fueron',
      PersonalPronoun.we => 'fuimos',
      PersonalPronoun.they => 'fueron',
      _ => 'fue',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _presentBeAsEstarEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'estoy',
      PersonalPronoun.you => 'estás/están',
      PersonalPronoun.we => 'estamos',
      PersonalPronoun.they => 'están',
      _ => 'está',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _pastBeAsEstarEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'estuve',
      PersonalPronoun.you => 'estuviste/estuvieron',
      PersonalPronoun.we => 'estuvimos',
      PersonalPronoun.they => 'estuvieron',
      _ => 'estuvo',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _presentHaveEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'he',
      PersonalPronoun.you => 'has/han',
      PersonalPronoun.we => 'hemos',
      PersonalPronoun.they => 'han',
      _ => 'ha',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _pastHaveEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.you => 'habías/habían',
      PersonalPronoun.we => 'habíamos',
      PersonalPronoun.they => 'habían',
      _ => 'había',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String get _futureHaveEs {
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => 'habré',
      PersonalPronoun.you => 'habrás/habrán',
      PersonalPronoun.we => 'habremos',
      PersonalPronoun.they => 'habrán',
      _ => 'habrá',
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  const IndependentClause({
    this.isModalVerbEnabled = false,
    this.isAffirmativeEmphasisEnabled = false,
    this.isVerbContractionEnabled = true,
    this.isNegativeContractionEnabled = false,
    this.clauseType = ClauseType.affirmative,
    this.tense = Tense.simplePresent,
    this.frontAdverb,
    this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verb,
    this.indirectObject,
    this.directObject,
    this.subjectComplement,
    this.endAdverb,
  });

  IndependentClause copyWith({
    bool? isModalVerbEnabled,
    bool? isAffirmativeEmphasisEnabled,
    bool? isVerbContractionEnabled,
    bool? isNegativeContractionEnabled,
    ClauseType? clauseType,
    Tense? tense,
    Nullable<AnyAdverb>? frontAdverb,
    Nullable<AnyNoun>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<AnyAdverb>? midAdverb,
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? indirectObject,
    Nullable<AnyNoun>? directObject,
    Nullable<SubjectComplement>? subjectComplement,
    Nullable<AnyAdverb>? endAdverb,
  }) =>
      IndependentClause(
        isModalVerbEnabled: isModalVerbEnabled ?? this.isModalVerbEnabled,
        isAffirmativeEmphasisEnabled:
            isAffirmativeEmphasisEnabled ?? this.isAffirmativeEmphasisEnabled,
        isVerbContractionEnabled:
            isVerbContractionEnabled ?? this.isVerbContractionEnabled,
        isNegativeContractionEnabled:
            isNegativeContractionEnabled ?? this.isNegativeContractionEnabled,
        clauseType: clauseType ?? this.clauseType,
        tense: tense ?? this.tense,
        frontAdverb: frontAdverb == null ? this.frontAdverb : frontAdverb.value,
        subject: subject == null ? this.subject : subject.value,
        modalVerb: modalVerb == null ? this.modalVerb : modalVerb.value,
        midAdverb: midAdverb == null ? this.midAdverb : midAdverb.value,
        verb: verb == null ? this.verb : verb.value,
        indirectObject:
            indirectObject == null ? this.indirectObject : indirectObject.value,
        directObject:
            directObject == null ? this.directObject : directObject.value,
        subjectComplement: subjectComplement == null
            ? this.subjectComplement
            : subjectComplement.value,
        endAdverb: endAdverb == null ? this.endAdverb : endAdverb.value,
      );

  String modalVerbAsString([ModalVerb? otherModalVerb]) {
    final modalVerb = this.modalVerb ?? otherModalVerb;
    return modalVerb == null
        ? modalVerbPlaceholder
        : isNegative
            ? isVerbContractionEnabled
                ? modalVerb.negativeVerbContraction
                : isNegativeContractionEnabled
                    ? modalVerb.negativeContraction
                    : modalVerb.negative
            : !isInterrogative && isVerbContractionEnabled
                ? modalVerb.verbContraction
                : modalVerb.verb;
  }

  String verbAsString([AnyVerb? otherVerb]) {
    AnyVerb? verb = otherVerb ?? this.verb;
    verb = verb is PhrasalVerb ? verb.verb : verb;
    return verb == null
        ? verbPlaceholder
        : verbTense == VerbTense.present
            ? verb is Be
                ? _presentBe
                : hasSingularThirdPersonSubject
                    ? _presentForSingularThirdPerson(verb)
                    : verb.infinitive
            : verbTense == VerbTense.past
                ? verb is Be
                    ? _pastBe
                    : (verb as Verb).past
                : verbTense == VerbTense.progressive
                    ? verb.progressive
                    : verbTense == VerbTense.pastParticiple
                        ? verb.pastParticiple
                        : verb.infinitive;
  }

  String _presentForSingularThirdPerson(AnyVerb verb) {
    final penultimateLetter = verb.infinitive
        .substring(verb.infinitive.length - 2, verb.infinitive.length - 1);
    final lastLetter = verb.infinitive.substring(verb.infinitive.length - 1);
    final lastTwoLetters =
        verb.infinitive.substring(verb.infinitive.length - 2);
    if (lastLetter == 'o' ||
        lastTwoLetters == 'sh' ||
        lastTwoLetters == 'ch' ||
        lastTwoLetters == 'ss' ||
        lastLetter == 'x' ||
        lastLetter == 'z') {
      return '${verb.infinitive}es';
    } else if (lastLetter == 'y' && Util.isConsonant(penultimateLetter)) {
      final newWord = verb.infinitive.substring(0, verb.infinitive.length - 1);
      return '${newWord}ies';
    }
    return '${verb.infinitive}s';
  }

  String modalVerbAsStringEs([ModalVerb? otherModalVerb]) {
    final modalVerb = this.modalVerb ?? otherModalVerb;
    if (modalVerb == null) {
      return modalVerbPlaceholderEs;
    }
    final affirmative = switch (subjectAsPronoun) {
      PersonalPronoun.I => modalVerb.affirmativeIEs,
      PersonalPronoun.you => modalVerb.affirmativeYouEs,
      PersonalPronoun.we => modalVerb.affirmativeWeEs,
      PersonalPronoun.they => modalVerb.affirmativeTheyEs,
      _ => modalVerb.affirmativeHeEs,
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }

  String verbAsStringEs([AnyVerb? otherVerb]) {
    final verb = otherVerb ?? this.verb;
    if (verb == null) {
      return verbPlaceholderEs;
    }
    if (verbTenseEs == VerbTense.present) {
      return switch (subjectAsPronoun) {
        PersonalPronoun.I => verb.presentIEs,
        PersonalPronoun.you => verb.presentYouEs,
        PersonalPronoun.we => verb.presentWeEs,
        PersonalPronoun.they => verb.presentTheyEs,
        _ => verb.presentHeEs,
      };
    } else if (verbTenseEs == VerbTense.past) {
      return switch (subjectAsPronoun) {
        PersonalPronoun.I => verb.pastIEs,
        PersonalPronoun.you => verb.pastYouEs,
        PersonalPronoun.we => verb.pastWeEs,
        PersonalPronoun.they => verb.pastTheyEs,
        _ => verb.pastHeEs,
      };
    } else if (verbTenseEs == VerbTense.future) {
      return switch (subjectAsPronoun) {
        PersonalPronoun.I => verb.futureIEs,
        PersonalPronoun.you => verb.futureYouEs,
        PersonalPronoun.we => verb.futureWeEs,
        PersonalPronoun.they => verb.futureTheyEs,
        _ => verb.futureHeEs,
      };
    } else if (verbTenseEs == VerbTense.conditional) {
      return switch (subjectAsPronoun) {
        PersonalPronoun.I => verb.conditionalIEs,
        PersonalPronoun.you => verb.conditionalYouEs,
        PersonalPronoun.we => verb.conditionalWeEs,
        PersonalPronoun.they => verb.conditionalTheyEs,
        _ => verb.conditionalHeEs,
      };
    } else if (verbTenseEs == VerbTense.progressive) {
      return verb.progressiveEs;
    } else if (verbTenseEs == VerbTense.pastParticiple) {
      return verb.pastParticipleEs;
    }
    return verb.infinitiveEs;
  }
}
