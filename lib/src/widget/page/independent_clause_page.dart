import 'package:flutter/material.dart';

import '../../extensions/string_extension.dart';
import '../../model/label.dart';
import '../../model/nullable.dart';
import '../../model/sentence/adverb/adverb_position.dart';
import '../../model/sentence/adverb/any_adverb.dart';
import '../../model/sentence/clause/clause_type.dart';
import '../../model/sentence/clause/independent_clause.dart';
import '../../model/sentence/clause/tense.dart';
import '../../model/sentence/noun/any_noun.dart';
import '../../model/sentence/noun/subject_complement.dart';
import '../../model/sentence/verb/any_verb.dart';
import '../../model/sentence/verb/phrasal_verb.dart';
import '../../model/word.dart';
import '../common/item_editor_layout.dart';
import '../common/item_tile.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/verb/first_auxiliary_verb_tile.dart';
import '../sentence/verb/verb_tile.dart';
import 'adverbial_phrase_page.dart';
import 'object_page.dart';
import 'subject_complement_page.dart';
import 'subject_page.dart';

class IndependentClausePage extends StatefulWidget {
  final IndependentClause? clause;

  const IndependentClausePage({super.key, this.clause});

  @override
  State<IndependentClausePage> createState() => _IndependentClausePageState();
}

class _IndependentClausePageState extends State<IndependentClausePage> {
  final mainVerbController = TextEditingController();
  late IndependentClause clause;
  bool isTenseFieldShown = false;
  bool isFirstAuxiliaryVerbSettingsShown = false;
  bool isMainVerbFieldShown = false;

  bool get isValid => clause.isValid;

  @override
  void initState() {
    super.initState();
    clause = widget.clause ?? const IndependentClause();
  }

  @override
  Widget build(BuildContext context) {
    final auxiliaryVerbs = clause.auxiliaryVerbs;

    final firstAuxiliaryVerbTile = FirstAuxiliaryVerbTile(
      clause: clause,
      setClause: setClause,
      isSettingsShown: isFirstAuxiliaryVerbSettingsShown,
      toggleFirstAuxiliaryVerbSettings: toggleFirstAuxiliaryVerbSettings,
      setVerb: setVerb,
      mainVerbController: mainVerbController,
    );

    return SentenceScaffold(
      title: 'Independent Clause',
      body: ItemEditorLayout(
        header: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: toggleIsFormShown,
                  icon: const Icon(Icons.chevron_left)),
              IndexedStack(
                index: isTenseFieldShown ? 0 : 1,
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownMenu<Tense>(
                      label: const Text('Tense'),
                      initialSelection: clause.tense,
                      dropdownMenuEntries: Tense.values
                          .map(
                              (e) => DropdownMenuEntry(value: e, label: e.name))
                          .toList(),
                      onSelected: (e) => setTense(e!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownMenu<ClauseType>(
                      label: const Text('Form'),
                      initialSelection: clause.clauseType,
                      dropdownMenuEntries: ClauseType.values
                          .map(
                              (e) => DropdownMenuEntry(value: e, label: e.name))
                          .toList(),
                      onSelected: (e) => setClauseType(e!),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: toggleIsFormShown,
                  icon: const Icon(Icons.chevron_right)),
            ],
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_ClauseTextEn(clause), _ClauseTextEs(clause)],
            ),
          ),
        ],
        body: [
          ItemTile(
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: clause.frontAdverb?.en,
            es: clause.frontAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToAdverbPage(context, AdverbPosition.front),
            isShown: !clause.isInterrogative,
          ),
          if (clause.isInterrogative) firstAuxiliaryVerbTile,
          ItemTile(
            style: Word.noun.style,
            placeholder: Label.subject,
            en: clause.subject?.en,
            es: clause.subject?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToSubjectPage(context),
            isRequired: true,
          ),
          if (!clause.isInterrogative) firstAuxiliaryVerbTile,
          ItemTile(
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: clause.midAdverb?.en,
            es: clause.midAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToAdverbPage(context, AdverbPosition.mid),
          ),
          ItemTile(
            style: Word.verb.style,
            placeholder: Label.auxiliaryVerb,
            en: auxiliaryVerbs.second,
            es: auxiliaryVerbs.secondEs,
            isShown: auxiliaryVerbs.second != null,
          ),
          ItemTile(
            style: Word.verb.style,
            placeholder: Label.auxiliaryVerb,
            en: auxiliaryVerbs.third,
            es: auxiliaryVerbs.thirdEs,
            isShown: auxiliaryVerbs.third != null,
          ),
          VerbTile(
            clause: clause,
            setVerb: setVerb,
            controller: mainVerbController,
            toggleField: toggleMainVerbField,
            isFieldShown: isMainVerbFieldShown,
            isShown: !clause.isBeAuxiliary,
          ),
          ItemTile(
            style: Word.noun.style,
            placeholder: Label.indirectObject,
            en: clause.indirectObject?.en,
            es: clause.indirectObject?.es,
            isShown: clause.hasDitransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToObjectPage(context, true),
            isRequired: true,
          ),
          ItemTile(
            style: Word.noun.style,
            placeholder: Label.directObject,
            en: clause.directObject?.en,
            es: clause.directObject?.es,
            isShown: clause.hasTransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToObjectPage(context, false),
            isRequired: true,
          ),
          ItemTile(
            style: Word.noun.style,
            placeholder: Label.subjectComplement,
            en: clause.subjectComplement?.en,
            es: clause.subjectComplement?.toEs(clause.hasPluralSubject),
            isShown: clause.canHaveSubjectComplement,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToComplementPage(context),
            isRequired: clause.verb?.isAlwaysLinkingVerb ?? false,
          ),
          ItemTile(
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: clause.endAdverb?.en,
            es: clause.endAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToAdverbPage(context, AdverbPosition.end),
          ),
        ],
      ),
    );
  }

  void goToSubjectPage(BuildContext context) async {
    final response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SubjectPage(clause: clause)));
    if (response != null) {
      setSubject(response is AnyNoun ? response : null);
    }
  }

  void goToObjectPage(BuildContext context, bool isIndirectObject) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: isIndirectObject
                      ? clause.indirectObject
                      : clause.directObject,
                  isDitransitiveVerb: clause.hasDitransitiveVerb,
                  isIndirectObject: isIndirectObject,
                  isNegative: clause.isNegative,
                  isPlural: clause.hasPluralSubject,
                )));
    if (response != null) {
      if (isIndirectObject) {
        setIndirectObject(response is AnyNoun ? response : null);
      } else {
        setDirectObject(response is AnyNoun ? response : null);
      }
    }
  }

  void goToComplementPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectComplementPage(
                  complement: clause.subjectComplement,
                  isNegative: clause.isNegative,
                  isPlural: clause.hasPluralSubject,
                )));
    if (response != null) {
      setComplement(response is SubjectComplement ? response : null);
    }
  }

  void goToAdverbPage(BuildContext context, AdverbPosition position) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbialPhrasePage(
                adverb: switch (position) {
                  AdverbPosition.front => clause.frontAdverb,
                  AdverbPosition.mid => clause.midAdverb,
                  _ => clause.endAdverb,
                },
                position: position,
                isNegative: clause.isNegative,
                isPlural: clause.hasPluralSubject)));
    if (response != null) {
      switch (position) {
        case AdverbPosition.front:
          setFrontAdverb(response is AnyAdverb ? response : null);
        case AdverbPosition.mid:
          setMidAdverb(response is AnyAdverb ? response : null);
        case _:
          setEndAdverb(response is AnyAdverb ? response : null);
      }
    }
  }

  setClause(IndependentClause clause) => setState(() => this.clause = clause);

  setFrontAdverb(AnyAdverb? adverb) =>
      setClause(clause.copyWith(frontAdverb: Nullable(adverb)));

  setSubject(AnyNoun? subject) =>
      setClause(clause.copyWith(subject: Nullable(subject)));

  setMidAdverb(AnyAdverb? adverb) =>
      setClause(clause.copyWith(midAdverb: Nullable(adverb)));

  setVerb(AnyVerb? verb) => setClause(clause.copyWith(verb: Nullable(verb)));

  setIndirectObject(AnyNoun? object) =>
      setClause(clause.copyWith(indirectObject: Nullable(object)));

  setDirectObject(AnyNoun? object) =>
      setClause(clause.copyWith(directObject: Nullable(object)));

  setComplement(SubjectComplement? complement) =>
      setClause(clause.copyWith(subjectComplement: Nullable(complement)));

  setEndAdverb(AnyAdverb? adverb) =>
      setClause(clause.copyWith(endAdverb: Nullable(adverb)));

  setTense(Tense tense) => setClause(clause.copyWith(tense: tense));

  setClauseType(ClauseType type) =>
      setClause(clause.copyWith(clauseType: type));

  saveItem(BuildContext context) => Navigator.pop(context, clause);

  toggleFirstAuxiliaryVerbSettings() => setState(() =>
      isFirstAuxiliaryVerbSettingsShown = !isFirstAuxiliaryVerbSettingsShown);

  toggleMainVerbField() =>
      setState(() => isMainVerbFieldShown = !isMainVerbFieldShown);

  toggleIsFormShown() => setState(() => isTenseFieldShown = !isTenseFieldShown);
}

class _ClauseTextEn extends StatelessWidget {
  final IndependentClause clause;

  const _ClauseTextEn(this.clause);

  @override
  Widget build(BuildContext context) {
    final aux = clause.auxiliaryVerbs;

    final firstAuxiliaryVerbSpan = TextSpan(
        text: aux.first?.addSpace(),
        style: aux.first == null ? Word.empty.style : Word.verb.style);

    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: !clause.isInterrogative
                ? clause.frontAdverb?.en.addSpace()
                : null,
            style: Word.adverb.style),
        if (clause.isInterrogative) firstAuxiliaryVerbSpan,
        TextSpan(
            text: (clause.subject?.en ?? Label.subject)
                .addSpace(!clause.isVerbContractionActive),
            style: clause.subject == null ? Word.empty.style : Word.noun.style),
        if (!clause.isInterrogative) firstAuxiliaryVerbSpan,
        TextSpan(
            text: clause.midAdverb?.en.addSpace(), style: Word.adverb.style),
        TextSpan(text: aux.second?.addSpace(), style: Word.verb.style),
        TextSpan(text: aux.third?.addSpace(), style: Word.verb.style),
        TextSpan(
            text: clause.isBeAuxiliary
                ? null
                : (clause.conjugateVerb() ?? clause.verbPlaceholder).addSpace(),
            style: clause.verb == null ? Word.empty.style : Word.verb.style),
        TextSpan(
            text: clause.hasDitransitiveVerb
                ? clause.indirectObject?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.hasTransitiveVerb
                ? clause.directObject?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.verb is PhrasalVerb
                ? (clause.verb as PhrasalVerb).particle.addSpace()
                : null,
            style: Word.verb.style),
        TextSpan(
            text: clause.canHaveSubjectComplement
                ? clause.subjectComplement?.en.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(text: clause.endAdverb?.en, style: Word.adverb.style),
        TextSpan(text: clause.isInterrogative ? '?' : null),
      ],
    ));
  }
}

class _ClauseTextEs extends StatelessWidget {
  final IndependentClause clause;

  const _ClauseTextEs(this.clause);

  @override
  Widget build(BuildContext context) {
    final aux = clause.auxiliaryVerbs;

    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: !clause.isInterrogative
                ? clause.frontAdverb?.es.addSpace()
                : null,
            style: Word.adverb.style),
        TextSpan(
            text: (clause.subject?.es ?? Label.subjectEs).addSpace(),
            style: clause.subject == null ? Word.empty.style : Word.noun.style),
        TextSpan(
            text: clause.midAdverb?.es.addSpace(), style: Word.adverb.style),
        TextSpan(
            text: clause.hasDitransitiveVerb
                ? clause.indirectObject?.es.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: clause.hasTransitiveVerb
                ? clause.directObject?.es.addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(
            text: aux.firstEs?.addSpace(aux.firstEs!.isNotEmpty),
            style: aux.firstEs == null ? Word.empty.style : Word.verb.style),
        TextSpan(text: aux.secondEs?.addSpace(), style: Word.verb.style),
        TextSpan(text: aux.thirdEs?.addSpace(), style: Word.verb.style),
        TextSpan(
            text: clause.isBeAuxiliary
                ? null
                : (clause.conjugateVerbEs() ?? clause.verbPlaceholderEs)
                    .addSpace(),
            style: clause.verb == null ? Word.empty.style : Word.verb.style),
        TextSpan(
            text: clause.canHaveSubjectComplement
                ? clause.subjectComplement
                    ?.toEs(clause.hasPluralSubject)
                    .addSpace()
                : null,
            style: Word.noun.style),
        TextSpan(text: clause.endAdverb?.es, style: Word.adverb.style),
        TextSpan(text: clause.isInterrogative ? '?' : null),
      ],
    ));
  }
}
