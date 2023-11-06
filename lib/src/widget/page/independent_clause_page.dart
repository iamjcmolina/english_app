import 'package:flutter/material.dart';

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
import '../../model/sentence/verb/modal_verb.dart';
import '../../model/word.dart';
import '../common/item_editor_layout.dart';
import '../common/sentence_item_tile.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/clause/clause_text.dart';
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
  final verbEditingController = TextEditingController();
  late IndependentClause clause;
  bool editingFirstAuxiliaryVerb = false;
  bool editingVerb = false;
  bool isFormShown = false;

  bool get isValid => clause.isValid;

  @override
  void initState() {
    super.initState();
    clause = widget.clause ?? const IndependentClause();
  }

  @override
  Widget build(BuildContext context) {
    final auxiliaryVerbs = clause.auxiliaryVerbs;

    final verbListItem = VerbTile(
      clause: clause,
      isEditingVerb: editingVerb,
      toggleEditingVerb: toggleEditingVerb,
      setVerb: setVerb,
      verbEditingController: verbEditingController,
      isShown: !clause.isBeAuxiliary,
    );
    final firstAuxiliaryVerbListItem = FirstAuxiliaryVerbTile(
      isEditingVerb: editingFirstAuxiliaryVerb,
      clause: clause,
      setClause: setClause,
      toggleEditingFirstAuxiliaryVerb: toggleEditingFirstAuxiliaryVerb,
      setModalVerb: setModalVerb,
      setVerb: setVerb,
      verbController: verbEditingController,
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
                index: isFormShown ? 1 : 0,
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
            title: ClauseText(clause: clause),
          ),
        ],
        body: [
          SentenceItemTile(
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: clause.frontAdverb?.en,
            es: clause.frontAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToAdverbPage(context, AdverbPosition.front),
            isShown: !clause.isInterrogative,
          ),
          if (clause.isInterrogative) firstAuxiliaryVerbListItem,
          SentenceItemTile(
            style: Word.noun.style,
            placeholder: Label.subject,
            en: clause.subject?.en,
            es: clause.subject?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToSubjectPage(context),
            isRequired: true,
          ),
          if (!clause.isInterrogative) firstAuxiliaryVerbListItem,
          SentenceItemTile(
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: clause.midAdverb?.en,
            es: clause.midAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToAdverbPage(context, AdverbPosition.mid),
          ),
          SentenceItemTile(
            style: Word.verb.style,
            placeholder: Label.auxiliaryVerb,
            en: auxiliaryVerbs.second,
            es: auxiliaryVerbs.secondEs,
            isShown: auxiliaryVerbs.second != null,
          ),
          SentenceItemTile(
            style: Word.verb.style,
            placeholder: Label.auxiliaryVerb,
            en: auxiliaryVerbs.third,
            es: auxiliaryVerbs.thirdEs,
            isShown: auxiliaryVerbs.third != null,
          ),
          if (!clause.isBeAuxiliary) verbListItem,
          SentenceItemTile(
            style: Word.noun.style,
            placeholder: Label.indirectObject,
            en: clause.indirectObject?.en,
            es: clause.indirectObject?.es,
            isShown: clause.hasDitransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToObjectPage(context, true),
            isRequired: true,
          ),
          SentenceItemTile(
            style: Word.noun.style,
            placeholder: Label.directObject,
            en: clause.directObject?.en,
            es: clause.directObject?.es,
            isShown: clause.hasTransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToObjectPage(context, false),
            isRequired: true,
          ),
          SentenceItemTile(
            style: Word.noun.style,
            placeholder: Label.subjectComplement,
            en: clause.subjectComplement?.en,
            es: clause.subjectComplement?.es,
            isShown: clause.hasLinkingVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToComplementPage(context),
            isRequired: true,
          ),
          SentenceItemTile(
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

  setModalVerb(ModalVerb? modalVerb) =>
      setClause(clause.copyWith(modalVerb: Nullable(modalVerb)));

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

  toggleEditingFirstAuxiliaryVerb() =>
      setState(() => editingFirstAuxiliaryVerb = !editingFirstAuxiliaryVerb);

  toggleEditingVerb() => setState(() => editingVerb = !editingVerb);

  toggleIsFormShown() => setState(() => isFormShown = !isFormShown);
}
