import 'package:flutter/material.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/independent_clause_settings.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/noun/subject_complement.dart';
import '../../../model/sentence/noun/undefined_subject.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../model/sentence/verb/undefined_modal_verb.dart';
import '../../../model/sentence/verb/undefined_verb.dart';
import '../../item_editor_layout.dart';
import '../adverb/adverb_page.dart';
import '../noun/object_page.dart';
import '../noun/subject_complement_page.dart';
import '../noun/subject_page.dart';
import '../verb/first_auxiliary_verb_list_item.dart';
import '../verb/verb_list_item.dart';
import 'clause_text.dart';
import '../../sentence_scaffold.dart';
import '../sentence_item_tile.dart';

class IndependentClausePage extends StatefulWidget {
  final IndependentClause? clause;

  const IndependentClausePage({super.key, this.clause});

  @override
  State<IndependentClausePage> createState() => _IndependentClausePageState();
}

class _IndependentClausePageState extends State<IndependentClausePage> {
  late IndependentClause clause;
  bool canSave = false;
  bool editingFirstAuxiliaryVerb = false;
  bool editingVerb = false;
  final TextEditingController verbEditingController = TextEditingController();

  IndependentClauseSettings get settings => clause.settings;
  AnyNoun get safeSubject => clause.subject ?? const UndefinedSubject();
  AnyVerb get safeVerb => clause.verb ?? const UndefinedVerb();
  int index = 0;

  @override
  void initState() {
    super.initState();
    clause = widget.clause ?? IndependentClause();
  }

  @override
  Widget build(BuildContext context) {
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
      setSettings: setSettings,
      checkCanSave: checkCanSave,
      toggleEditingFirstAuxiliaryVerb: toggleEditingFirstAuxiliaryVerb,
      setModalVerb: setModalVerb,
      setVerb: setVerb,
      verbEditingController: verbEditingController,
    );

    return SentenceScaffold(
      title: 'Independent Clause',
      // bottomActions: [
      //   IconButton(
      //       onPressed: canSave? () => saveItem(context) : null,
      //       icon: const Icon(Icons.save)
      //   ),
      //   IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.clear)
      //   ),
      // ],
      body: ItemEditorLayout(
        header: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => setState(() => index = index == 0? 1 : 0),
                child: const Icon(Icons.chevron_left),
              ),
              IndexedStack(
                index: index,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownMenu<Tense>(
                      initialSelection: settings.tense,
                      label: const Text('Tense'),
                      dropdownMenuEntries: Tense.values
                          .map<DropdownMenuEntry<Tense>>(
                              (Tense item) => DropdownMenuEntry<Tense>(
                            value: item,
                            label: item.name,
                          )).toList(),
                      onSelected: (Tense? tense) => setTense(tense!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownMenu<ClauseType>(
                      initialSelection: settings.clauseType,
                      label: const Text('Clause type'),
                      dropdownMenuEntries: ClauseType.values
                          .map<DropdownMenuEntry<ClauseType>>(
                              (ClauseType item) => DropdownMenuEntry<ClauseType>(
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
                onTap: () => setState(() => index = index == 0? 1 : 0),
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
            color: IndependentClausePartColor.adverb.color,
            label: clause.undefinedFrontAdverb.toString(),
            value: clause.frontAdverb?.toString(),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.front),
            show: settings.isInterrogative,
          ),
          if (settings.isInterrogative)
            firstAuxiliaryVerbListItem,
          SentenceItemTile(
            color: IndependentClausePartColor.noun.color,
            label: clause.undefinedSubject.toString(),
            value: clause.subject?.toString(),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToSubjectPage(context),
            required: true,
          ),
          if (!settings.isInterrogative)
            firstAuxiliaryVerbListItem,
          SentenceItemTile(
            color: IndependentClausePartColor.adverb.color,
            label: clause.undefinedMiddleAdverb.toString(),
            value: clause.midAdverb?.toString(),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.mid),
          ),
          SentenceItemTile(
            color: IndependentClausePartColor.verb.color,
            label: clause.undefinedSecondAuxiliaryVerb,
            value: clause.secondAuxiliaryVerb,
            show: clause.secondAuxiliaryVerb != null,
          ),
          SentenceItemTile(
            color: IndependentClausePartColor.verb.color,
            label: clause.undefinedThirdAuxiliaryVerb,
            value: clause.thirdAuxiliaryVerb,
            show: clause.thirdAuxiliaryVerb != null,
          ),
          if (!clause.isBeAuxiliary) verbListItem,
          SentenceItemTile(
            color: IndependentClausePartColor.noun.color,
            label: clause.undefinedIndirectObject.toString(),
            value: clause.indirectObject?.toString(),
            show: safeVerb.isDitransitive,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToObjectPage(context, true),
          ),
          SentenceItemTile(
            color: IndependentClausePartColor.noun.color,
            label: clause.undefinedDirectObject.toString(),
            value: clause.directObject?.toString(),
            show: safeVerb.isTransitive,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToObjectPage(context, false),
          ),
          SentenceItemTile(
            color: IndependentClausePartColor.noun.color,
            label: clause.undefinedSubjectComplement.toString(),
            value: clause.subjectComplement?.toString(),
            show: safeVerb.isLinkingVerb,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToComplementPage(context),
            required: true,
          ),
          SentenceItemTile(
            color: IndependentClausePartColor.adverb.color,
            label: clause.undefinedEndAdverb.toString(),
            value: clause.endAdverb?.toString(),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToAdverbPage(context, AdverbPosition.end),
          ),
        ],
      ),
    );
  }

  navigateToSubjectPage(BuildContext context) async {
    final subject = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectPage(
              subject: clause.subject,
            )));
    if (subject is AnyNoun) {
      setSubject(subject);
    } else if(subject is bool && !subject) {
      setSubject(null);
    }
  }

  navigateToObjectPage(BuildContext context, bool isIndirectObject) async {
    final object = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
              object: isIndirectObject? clause.indirectObject
                  : clause.directObject,
              isDitransitiveVerb: safeVerb.isDitransitive,
              isIndirectObject: isIndirectObject,
            )));
    if (object is AnyNoun) {
      if (isIndirectObject) {
        setIndirectObject(object);
      } else {
        setDirectObject(object);
      }
    } else if(object is bool && !object) {
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
    } else if(complement is bool && !complement) {
      setComplement(null);
    }
  }

  navigateToAdverbPage(BuildContext context, AdverbPosition position) async {
    final adverb = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbPage(
              adverb: switch(position) {
                AdverbPosition.front => clause.frontAdverb,
                AdverbPosition.mid => clause.midAdverb,
                _ => clause.endAdverb,
              },
              position: position,
            )));
    if (adverb is AnyAdverb) {
      switch(position) {
        case AdverbPosition.front: setFrontAdverb(adverb); break;
        case AdverbPosition.mid: setMidAdverb(adverb); break;
        case _: setEndAdverb(adverb); break;
      }
    } else if(adverb is bool && !adverb) {
      switch(position) {
        case AdverbPosition.front: setFrontAdverb(null); break;
        case AdverbPosition.mid: setMidAdverb(null); break;
        case _: setEndAdverb(null); break;
      }
    }
  }

  setClause(IndependentClause clause) => setState(()=> this.clause = clause);

  setFrontAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(frontAdverb: Nullable(adverb)));

  setSubject(AnyNoun? subject) => setClause(clause.copyWith(subject: Nullable(subject)));

  setModalVerb(ModalVerb? modalVerb) => setClause(clause.copyWith(modalVerb: Nullable(modalVerb)));

  setMidAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(midAdverb: Nullable(adverb)));

  setVerb(AnyVerb? verb) => setClause(clause.copyWith(verb: Nullable(verb)));

  setIndirectObject(AnyNoun? object) => setClause(clause.copyWith(indirectObject: Nullable(object)));

  setDirectObject(AnyNoun? object) => setClause(clause.copyWith(directObject: Nullable(object)));

  setComplement(SubjectComplement? complement) =>
      setClause(clause.copyWith(subjectComplement: Nullable(complement)));

  setEndAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(endAdverb: Nullable(adverb)));

  setSettings(IndependentClauseSettings options) => setClause(clause.copyWith(settings: options));

  setTense(Tense tense) => setSettings(settings.copyWith(tense: tense));

  setClauseType(ClauseType type) => setSettings(settings.copyWith(clauseType: type));

  saveItem(BuildContext context) => Navigator.pop(context, clause);

  toggleEditingFirstAuxiliaryVerb() =>
      setState(() => editingFirstAuxiliaryVerb = !editingFirstAuxiliaryVerb);

  toggleEditingVerb() => setState(() => editingVerb = !editingVerb);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);

  checkCanSave() => setCanSave(
      clause.modalVerb is! UndefinedModalVerb && clause.verb is! UndefinedVerb
  );
}
