import 'package:flutter/material.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/noun/subject_complement.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../item_editor_layout.dart';
import '../../sentence_scaffold.dart';
import '../adverb/adverb_page.dart';
import '../noun/object_page.dart';
import '../noun/subject_complement_page.dart';
import '../noun/subject_page.dart';
import '../sentence_item_tile.dart';
import '../verb/first_auxiliary_verb_list_item.dart';
import '../verb/verb_list_item.dart';
import 'clause_text.dart';

class IndependentClausePage extends StatefulWidget {
  final IndependentClause? clause;

  const IndependentClausePage({super.key, this.clause});

  @override
  State<IndependentClausePage> createState() => _IndependentClausePageState();
}

class _IndependentClausePageState extends State<IndependentClausePage> {
  final verbEditingController = TextEditingController();
  late IndependentClause clause;
  bool canSave = false;
  bool editingFirstAuxiliaryVerb = false;
  bool editingVerb = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    clause = widget.clause ?? const IndependentClause();
  }

  @override
  Widget build(BuildContext context) {
    final auxiliaryVerbs = clause.auxiliaryVerbs;
    final auxiliaryVerbsEs = clause.auxiliaryVerbsEs;

    final verbListItem = VerbListItem(
      clause: clause,
      editingVerb: editingVerb,
      toggleEditingVerb: toggleEditingVerb,
      checkCanSave: checkCanSave,
      setVerb: setVerb,
      verbEditingController: verbEditingController,
      show: !clause.isBeAuxiliary,
    );
    final firstAuxiliaryVerbListItem = FirstAuxiliaryVerbListItem(
      editingFirstAuxiliaryVerb: editingFirstAuxiliaryVerb,
      clause: clause,
      setClause: setClause,
      checkCanSave: checkCanSave,
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
              GestureDetector(
                onTap: () => setState(() => index = index == 0 ? 1 : 0),
                child: const Icon(Icons.chevron_left),
              ),
              IndexedStack(
                index: index,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownMenu<Tense>(
                      initialSelection: clause.tense,
                      label: const Text('Tense'),
                      dropdownMenuEntries: Tense.values
                          .map<DropdownMenuEntry<Tense>>(
                              (Tense item) => DropdownMenuEntry<Tense>(
                                    value: item,
                                    label: item.name,
                                  ))
                          .toList(),
                      onSelected: (Tense? tense) => setTense(tense!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownMenu<ClauseType>(
                      initialSelection: clause.clauseType,
                      label: const Text('Clause type'),
                      dropdownMenuEntries: ClauseType.values
                          .map<DropdownMenuEntry<ClauseType>>(
                              (ClauseType item) =>
                                  DropdownMenuEntry<ClauseType>(
                                    value: item,
                                    label: item.name,
                                  ))
                          .toList(),
                      onSelected: (ClauseType? type) => setClauseType(type!),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => index = index == 0 ? 1 : 0),
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          ListTile(
            title: ClauseText(clause: clause),
          ),
        ],
        body: [
          SentenceItemTile(
            color: SentenceItem.adverb.color,
            label: clause.frontAdverbPlaceholder,
            value: clause.frontAdverb?.toString(),
            valueEs: clause.frontAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.front),
            show: clause.isInterrogative,
          ),
          if (clause.isInterrogative) firstAuxiliaryVerbListItem,
          SentenceItemTile(
            color: SentenceItem.noun.color,
            label: clause.subjectPlaceholder,
            value: clause.subject?.toString(),
            valueEs: clause.subject?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToSubjectPage(context),
            required: true,
          ),
          if (!clause.isInterrogative) firstAuxiliaryVerbListItem,
          SentenceItemTile(
            color: SentenceItem.adverb.color,
            label: clause.midAdverbPlaceholder,
            value: clause.midAdverb?.toString(),
            valueEs: clause.midAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.mid),
          ),
          SentenceItemTile(
            color: SentenceItem.verb.color,
            label: clause.secondAuxiliaryVerbPlaceholder,
            value: auxiliaryVerbs.second,
            valueEs: auxiliaryVerbsEs.second,
            show: auxiliaryVerbs.second != null,
          ),
          SentenceItemTile(
            color: SentenceItem.verb.color,
            label: clause.thirdAuxiliaryVerbPlaceholder,
            value: auxiliaryVerbs.third,
            valueEs: auxiliaryVerbsEs.third,
            show: auxiliaryVerbs.third != null,
          ),
          if (!clause.isBeAuxiliary) verbListItem,
          SentenceItemTile(
            color: SentenceItem.noun.color,
            label: clause.indirectObjectPlaceholder,
            value: clause.indirectObject?.toString(),
            valueEs: clause.indirectObject?.es,
            show: clause.hasDitransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToObjectPage(context, true),
          ),
          SentenceItemTile(
            color: SentenceItem.noun.color,
            label: clause.directObjectPlaceholder,
            value: clause.directObject?.toString(),
            valueEs: clause.directObject?.es,
            show: clause.hasTransitiveVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToObjectPage(context, false),
          ),
          SentenceItemTile(
            color: SentenceItem.noun.color,
            label: clause.subjectComplementPlaceholder,
            value: clause.subjectComplement?.toString(),
            show: clause.hasLinkingVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToComplementPage(context),
            required: true,
          ),
          SentenceItemTile(
            color: SentenceItem.adverb.color,
            label: clause.endAdverbPlaceholder,
            value: clause.endAdverb?.toString(),
            valueEs: clause.endAdverb?.es,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.end),
          ),
        ],
      ),
    );
  }

  navigateToSubjectPage(BuildContext context) async {
    final subject = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SubjectPage(clause: clause)));
    if (subject is AnyNoun) {
      setSubject(subject);
    } else if (subject is bool && !subject) {
      setSubject(null);
    }
  }

  navigateToObjectPage(BuildContext context, bool isIndirectObject) async {
    final object = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: isIndirectObject
                      ? clause.indirectObject
                      : clause.directObject,
                  isDitransitiveVerb: clause.hasDitransitiveVerb,
                  isIndirectObject: isIndirectObject,
                  isNegative: clause.isNegative,
                )));
    if (object is AnyNoun) {
      if (isIndirectObject) {
        setIndirectObject(object);
      } else {
        setDirectObject(object);
      }
    } else if (object is bool && !object) {
      if (isIndirectObject) {
        setIndirectObject(null);
      } else {
        setDirectObject(null);
      }
    }
  }

  navigateToComplementPage(BuildContext context) async {
    final complement = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectComplementPage(
                  complement: clause.subjectComplement,
                )));
    if (complement is SubjectComplement) {
      setComplement(complement);
    } else if (complement is bool && !complement) {
      setComplement(null);
    }
  }

  navigateToAdverbPage(BuildContext context, AdverbPosition position) async {
    final adverb = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbPage(
                  adverb: switch (position) {
                    AdverbPosition.front => clause.frontAdverb,
                    AdverbPosition.mid => clause.midAdverb,
                    _ => clause.endAdverb,
                  },
                  position: position,
                )));
    if (adverb is AnyAdverb) {
      switch (position) {
        case AdverbPosition.front:
          setFrontAdverb(adverb);
          break;
        case AdverbPosition.mid:
          setMidAdverb(adverb);
          break;
        case _:
          setEndAdverb(adverb);
          break;
      }
    } else if (adverb is bool && !adverb) {
      switch (position) {
        case AdverbPosition.front:
          setFrontAdverb(null);
          break;
        case AdverbPosition.mid:
          setMidAdverb(null);
          break;
        case _:
          setEndAdverb(null);
          break;
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

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);

  checkCanSave() => setCanSave(clause.modalVerb != null && clause.verb != null);
}
