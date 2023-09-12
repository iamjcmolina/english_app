import 'package:flutter/material.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/independent_clause_settings.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/noun/subject.dart';
import '../../../model/sentence/noun/undefined_subject.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/be.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../model/sentence/verb/undefined_modal_verb.dart';
import '../../../model/sentence/verb/undefined_verb.dart';
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
  bool showBottomAppBar = false;
  bool editingFirstAuxiliaryVerb = false;
  bool editingVerb = false;
  final TextEditingController verbEditingController = TextEditingController();

  IndependentClauseSettings get settings => clause.settings;
  Subject get safeSubject => clause.subject ?? const UndefinedSubject();
  AnyVerb get safeVerb => clause.verb ?? const UndefinedVerb();

  @override
  Widget build(BuildContext context) {
    final clauseMap = {
      'frontAdverb': false? null :'Undoubtedly',
      'subject': clause.subject.toString(),//false? null :'you',
      'firstAuxiliaryVerb': false? null :'will',
      'middleAdverb': true? null :'always',
      'secondAuxiliaryVerb': false? null :'have',
      'thirdAuxiliaryVerb': false? null :'been',
      'verb': false? null :'working',
      'indirectObject': null,
      'directObject': null,
      'subjectComplement': null,
      'endAdverb': true? null :'quickly',
    };
    final verbListItem = VerbListItem(
      color: IndependentClausePartColor.verb.color,
      verb: clause.verb,
      setVerb: setVerb,
      subject: clause.subject,
      isBeAuxiliary: clause.isBeAuxiliary,
      editingVerb: editingVerb,
      toggleEditingVerb: toggleEditingVerb,
      settings: settings,
      showOrHideBottomAppBar: showOrHideBottomAppBar,
      toggleModalVerb: toggleModalVerb,
      toggleContraction: toggleContraction,
      toggleNegativeContraction: toggleNegativeContraction,
      textEditingController: verbEditingController,
    );
    final firstAuxiliaryVerbListItem = clause.isBeAuxiliary? verbListItem
        : FirstAuxiliaryVerbListItem(
      color: IndependentClausePartColor.verb.color,
      editingFirstAuxiliaryVerb: editingFirstAuxiliaryVerb,
      isBeAuxiliary: clause.isBeAuxiliary,
      value: clause.auxiliaries.elementAt(0),
      modalVerb: clause.modalVerb,
      setModalVerb: setModalVerb,
      settings: settings,
      setSettings: setSettings,
      showOrHideBottomAppBar: showOrHideBottomAppBar,
      toggleEditingFirstAuxiliaryVerb: toggleEditingFirstAuxiliaryVerb,
      toggleModalVerb: toggleModalVerb,
      toggleAffirmativeEmphasis: toggleAffirmativeEmphasis,
      toggleContraction: toggleContraction,
      toggleNegativeContraction: toggleNegativeContraction,
    );

    return RootLayout(
      title: 'Independent Clause',
      showBottomAppBar: showBottomAppBar,
      bottomAppBarChildren: [
        IconButton(
            onPressed: () => onSavePage(context),
            icon: const Icon(Icons.save)
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (editingSettings) Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: const Text('Settings'),
                leading: const Icon(Icons.settings),
                trailing: const Icon(Icons.arrow_drop_up),
                onTap: () => toggleEditingSettings(),
              ),
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
          if (!editingSettings) ListTile(
            title: Text.rich(TextSpan(
              style: const TextStyle(fontSize: 13),
              children: [
                const TextSpan(
                  text: 'Tense: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: settings.tense.name),
                const TextSpan(
                  text: '\nClause type: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: settings.clauseType.name),
              ]
            )),
            //leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () => toggleEditingSettings(),
          ),
          ListTile(
            title: ClauseText(clause: clause),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      if (settings.clauseType != ClauseType.interrogative)
                        SentenceItemTile(
                          color: IndependentClausePartColor.adverb.color,
                          label: 'Front Adverb',
                          value: clauseMap['frontAdverb'],
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      if (settings.isInterrogative)
                        firstAuxiliaryVerbListItem,
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Subject',
                        value: clause.subject?.toString(),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => navigateToSubjectPage(context),
                      ),
                      if (!settings.isInterrogative)
                        firstAuxiliaryVerbListItem,
                      SentenceItemTile(
                        color: IndependentClausePartColor.adverb.color,
                        label: 'Middle Adverb',
                        value: clauseMap['middleAdverb'],
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      if (clause.auxiliaries.length > 1) SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'Second Auxiliary Verb',
                        value: clause.auxiliaries.elementAt(1),
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        hide: clauseMap['secondAuxiliaryVerb'] == null,
                      ),
                      if (clause.auxiliaries.length > 2) SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'Third Auxiliary Verb',
                        value: clause.auxiliaries.elementAt(2),
                        // trailing: const Icon(Icons.arrow_forward_ios),
                        hide: clauseMap['thirdAuxiliaryVerb'] == null,
                      ),
                      if (!clause.isBeAuxiliary) verbListItem,
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Indirect Object',
                        value: clauseMap['indirectObject'],
                        hide: !safeVerb.isDitransitive,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Direct Object',
                        value: clauseMap['directObject'],
                        hide: !safeVerb.isTransitive,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Subject Complement',
                        value: clauseMap['subjectComplement'],
                        hide: !safeVerb.isLinkingVerb,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.adverb.color,
                        label: 'End Adverb',
                        value: clauseMap['endAdverb'],
                        trailing: const Icon(Icons.arrow_forward_ios),
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

  setSubject(Subject? subject) => setClause(clause.copyWith(subject: Nullable(subject)));

  setModalVerb(ModalVerb? modalVerb) => setClause(clause.copyWith(modalVerb: Nullable(modalVerb)));

  setVerb(AnyVerb? verb) => setClause(clause.copyWith(
    verb: Nullable(verb),
  ));

  setSettings(IndependentClauseSettings options) => setClause(clause.copyWith(settings: options));

  toggleModalVerb() => setSettings(settings.copyWith(
    modalVerb: !settings.modalVerb,
    affirmativeEmphasis: false,
    negativeContraction: false,
  ));

  toggleAffirmativeEmphasis() => setSettings(settings.copyWith(
    affirmativeEmphasis: !settings.affirmativeEmphasis,
    modalVerb: false,
    contraction: false,
  ));

  toggleContraction() {
    setSettings(settings.copyWith(
      contraction: !settings.contraction,
      negativeContraction: false,
    ));
    verbEditingController.text = AnyVerb.verbToString(safeVerb, safeSubject, settings);
  }

  toggleNegativeContraction() => setSettings(settings.copyWith(
    negativeContraction: !settings.negativeContraction,
    contraction: false,
    modalVerb: false,
    affirmativeEmphasis: false,
  ));

  setTense(Tense tense) => setSettings(settings.copyWith(tense: tense));

  setClauseType(ClauseType type) => setSettings(settings.copyWith(clauseType: type));

  onSavePage(BuildContext context) => Navigator.pop(context, clause);

  toggleEditingSettings() => setState(() => editingSettings = !editingSettings);

  toggleEditingFirstAuxiliaryVerb() =>
      setState(() => editingFirstAuxiliaryVerb = !editingFirstAuxiliaryVerb);

  toggleEditingVerb() => setState(() => editingVerb = !editingVerb);

  showOrHideBottomAppBar() => setState(() => showBottomAppBar =
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
    if (subject is Subject) {
      setSubject(subject);
    }
  }

  @override
  void initState() {
    super.initState();
    clause = widget.clause ?? IndependentClause();
  }
}

class FirstAuxiliaryVerbSettings extends StatelessWidget {
  FirstAuxiliaryVerbSettings({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        if (showModalVerbField) SentenceItemField<ModalVerb>(
          label: 'Modal Verb',
          value: modalVerb,
          options: ModalVerb.modalVerbs,
          displayStringForOption: (modalVerb) => modalVerbToString(modalVerb),
          onSelected: onModalVerbSelected,
          onCleaned: () => onModalVerbCleaned(),
          onChanged: (text) => onModalVerbChanged(),
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Modal Verb'),
          secondary: const Icon(Icons.add),
          dense: true,
          value: settings.modalVerb,
          onChanged: settings.isSimplePresent? (bool value) => toggleModalVerb() : null,
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          secondary: const Icon(Icons.add),
          title: const Text('Affirmative present or past emphasis'),
          value: settings.affirmativeEmphasis,
          dense: true,
          onChanged: isSimplePresentOrPast && settings.isAffirmative
              ? (value) => toggleAffirmativeEmphasis()
              : null,
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Subject'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.contraction,
          onChanged: (value) => toggleContraction(),
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Negative Contraction'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.negativeContraction,
          onChanged: settings.isNegative
              ? (value) => toggleNegativeContraction()
              : null,
        ),
      ],
    );
  }

  void onModalVerbSelected(ModalVerb modalVerb) {
    setModalVerb(modalVerb);
    toggleEditingFirstAuxiliaryVerb();
    // showOrHideBottomAppBar();
  }

  onModalVerbCleaned() {
    // onModalVerbChanged();
    // toggleEditingFirstAuxiliaryVerb();
  }

  onModalVerbChanged() {
    // setModalVerb(null);
    // showOrHideBottomAppBar();
  }

  String modalVerbToString(ModalVerb modalVerb) =>
      settings.clauseType == ClauseType.negative
          ? modalVerb.negativeValue(settings.negativeContraction)
          : modalVerb.affirmativeValue(settings.contraction);
}

