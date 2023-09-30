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
import '../../../model/sentence/noun/undefined_subject.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../model/sentence/verb/undefined_modal_verb.dart';
import '../../../model/sentence/verb/undefined_verb.dart';
import '../adverb/adverb_page.dart';
import '../noun/subject_page.dart';
import '../verb/first_auxiliary_verb_list_item.dart';
import '../verb/verb_list_item.dart';
import 'clause_text.dart';
import '../../root_layout.dart';
import '../sentence_item_tile.dart';

class IndependentClausePage extends StatefulWidget {
  final IndependentClause? clause;

  const IndependentClausePage({super.key, this.clause});

  @override
  State<IndependentClausePage> createState() => _IndependentClausePageState();
}

class _IndependentClausePageState extends State<IndependentClausePage> {
  late IndependentClause clause;
  bool editingSettings = false;
  bool isBottomAppBarShown = false;
  bool editingFirstAuxiliaryVerb = false;
  bool editingVerb = false;
  final TextEditingController verbEditingController = TextEditingController();
  late ScrollController _controller;

  IndependentClauseSettings get settings => clause.settings;
  AnyNoun get safeSubject => clause.subject ?? const UndefinedSubject();
  AnyVerb get safeVerb => clause.verb ?? const UndefinedVerb();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final verbListItem = VerbListItem(
      clause: clause,
      editingVerb: editingVerb,
      toggleEditingVerb: toggleEditingVerb,
      showOrHideBottomAppBar: showOrHideBottomAppBar,
      setVerb: setVerb,
      verbEditingController: verbEditingController,
      hide: clause.isBeAuxiliary,
    );
    final firstAuxiliaryVerbListItem = FirstAuxiliaryVerbListItem(
      editingFirstAuxiliaryVerb: editingFirstAuxiliaryVerb,
      clause: clause,
      setSettings: setSettings,
      showOrHideBottomAppBar: showOrHideBottomAppBar,
      toggleEditingFirstAuxiliaryVerb: toggleEditingFirstAuxiliaryVerb,
      setModalVerb: setModalVerb,
      setVerb: setVerb,
      verbEditingController: verbEditingController,
    );

    return RootLayout(
      title: 'Independent Clause',
      showBottomAppBar: isBottomAppBarShown,
      controller: _controller,
      bottomAppBarChildren: [
        IconButton(
            onPressed: () => onSavePage(context),
            icon: const Icon(Icons.save)
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
          ListTile(
            title: ClauseText(clause: clause),
          ),
          Expanded(
            child: ListView(
              controller: _controller,
              children: [
                Card(
                  child: Column(
                    children: [
                      SentenceItemTile(
                        color: IndependentClausePartColor.adverb.color,
                        label: clause.undefinedFrontAdverb.toString(),
                        value: clause.frontAdverb?.toString(),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => navigateToAdverbPage(context, AdverbPosition.front),
                        hide: settings.isInterrogative,
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
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        hide: clause.secondAuxiliaryVerb == null,
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: clause.undefinedThirdAuxiliaryVerb,
                        value: clause.thirdAuxiliaryVerb,
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        hide: clause.thirdAuxiliaryVerb == null,
                      ),
                      if (!clause.isBeAuxiliary) verbListItem,
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: clause.undefinedIndirectObject.toString(),
                        value: clause.indirectObject?.toString(),
                        hide: !safeVerb.isDitransitive,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: clause.undefinedDirectObject.toString(),
                        value: clause.directObject?.toString(),
                        hide: !safeVerb.isTransitive,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: clause.undefinedSubjectComplement.toString(),
                        value: clause.subjectComplement?.toString(),
                        hide: !safeVerb.isLinkingVerb,
                        trailing: const Icon(Icons.arrow_forward_ios),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setClause(IndependentClause clause) => setState(()=> this.clause = clause);

  setFrontAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(frontAdverb: Nullable(adverb)));

  setSubject(AnyNoun? subject) => setClause(clause.copyWith(subject: Nullable(subject)));

  setModalVerb(ModalVerb? modalVerb) => setClause(clause.copyWith(modalVerb: Nullable(modalVerb)));

  setMidAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(midAdverb: Nullable(adverb)));

  setVerb(AnyVerb? verb) => setClause(clause.copyWith(verb: Nullable(verb)));

  setEndAdverb(AnyAdverb? adverb) => setClause(clause.copyWith(endAdverb: Nullable(adverb)));

  setSettings(IndependentClauseSettings options) => setClause(clause.copyWith(settings: options));

  setTense(Tense tense) => setSettings(settings.copyWith(tense: tense));

  setClauseType(ClauseType type) => setSettings(settings.copyWith(clauseType: type));

  onSavePage(BuildContext context) => Navigator.pop(context, clause);

  toggleEditingSettings() => setState(() => editingSettings = !editingSettings);

  toggleEditingFirstAuxiliaryVerb() =>
      setState(() => editingFirstAuxiliaryVerb = !editingFirstAuxiliaryVerb);

  toggleEditingVerb() => setState(() => editingVerb = !editingVerb);

  showOrHideBottomAppBar() => setState(() => isBottomAppBarShown =
      clause.modalVerb is! UndefinedModalVerb && clause.verb is! UndefinedVerb
  );
  
  navigateToSubjectPage(BuildContext context) async {
    final subject = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectPage(
              subjectType: settings.subjectType,
              subject: clause.subject,
            )));
    if (subject is AnyNoun) {
      setSubject(subject);
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
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    clause = widget.clause ?? IndependentClause();
  }
}
