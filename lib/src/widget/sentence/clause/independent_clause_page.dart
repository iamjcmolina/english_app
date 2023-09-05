import 'package:flutter/material.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/noun/subject.dart';
import '../noun/pronoun_form.dart';
import '../noun/subject_page.dart';
import 'clause_text.dart';
import '../../root_layout.dart';
import '../sentence_item_tile.dart';

class IndependentClausePage extends StatefulWidget {
  final IndependentClause clause;

  const IndependentClausePage({super.key, required this.clause});

  @override
  State<IndependentClausePage> createState() => _IndependentClausePageState();
}

class _IndependentClausePageState extends State<IndependentClausePage> {
  late IndependentClause clause;
  bool settingsOpen = false;

  @override
  void initState() {
    super.initState();
    clause = widget.clause;
  }

  @override
  Widget build(BuildContext context) {
    final clauseMap = {
      'frontAdverb': false? null :'Undoubtedly',
      'subject': clause.subject?.toString(),//false? null :'you',
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
    return RootLayout(
      title: 'Independent Clause',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: ClauseText(
              frontAdverb: clauseMap['frontAdverb'],
              subject: clauseMap['subject'],
              firstAuxiliaryVerb: clauseMap['firstAuxiliaryVerb'],
              middleAdverb: clauseMap['middleAdverb'],
              secondAuxiliaryVerb: clauseMap['secondAuxiliaryVerb'],
              thirdAuxiliaryVerb: clauseMap['thirdAuxiliaryVerb'],
              verb: clauseMap['verb'],
              indirectObject: clauseMap['indirectObject'],
              directObject: clauseMap['directObject'],
              subjectComplement: clauseMap['subjectComplement'],
              endAdverb: clauseMap['endAdverb'],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (settingsOpen) Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text('Settings'),
                        leading: const Icon(Icons.settings),
                        trailing: const Icon(Icons.arrow_drop_up),
                        onTap: () {
                          setState(() {
                            settingsOpen = !settingsOpen;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<Tense>(
                          initialSelection: clause.options.tense,
                          label: const Text('Tense'),
                          dropdownMenuEntries: Tense.values
                              .map<DropdownMenuEntry<Tense>>(
                                  (Tense item) => DropdownMenuEntry<Tense>(
                                value: item,
                                label: item.name,
                              ))
                              .toList(),
                          onSelected: (Tense? tense) {
                            setState(() {
                              clause.options = clause.options.copyWith(tense: tense);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<ClauseType>(
                          initialSelection: clause.options.clauseType,
                          label: const Text('Clause type'),
                          dropdownMenuEntries: ClauseType.values
                              .map<DropdownMenuEntry<ClauseType>>(
                                  (ClauseType item) => DropdownMenuEntry<ClauseType>(
                                value: item,
                                label: item.name,
                              ))
                              .toList(),
                          onSelected: (ClauseType? clauseType) {
                            setState(() {
                              clause.options = clause.options.copyWith(clauseType: clauseType);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.view_day),
                        title: const Text('Modal Verb'),
                        dense: true,
                        trailing: Switch(
                          value: clause.options.modalVerb,
                          onChanged: (value) {
                            setState(() {
                              clause.options = clause.options.copyWith(modalVerb: !clause.options.modalVerb);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.view_day),
                        title: const Text('Affirmative emphasis'),
                        dense: true,
                        trailing: Switch(
                          value: clause.options.affirmativeEmphasis,
                          onChanged: (value) {
                            setState(() {
                              clause.options = clause.options.copyWith(affirmativeEmphasis: !clause.options.affirmativeEmphasis);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.compress),
                        title: const Text('Collapse first auxiliary verb'),
                        dense: true,
                        trailing: Switch(
                          value: clause.options.collapseFirstAuxiliaryVerb,
                          onChanged: (value) {
                            setState(() {
                              clause.options = clause.options.copyWith(collapseFirstAuxiliaryVerb: !clause.options.collapseFirstAuxiliaryVerb);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.compress),
                        title: const Text('Collapse negative first auxiliary verb'),
                        dense: true,
                        trailing: Switch(
                          value: clause.options.collapseNegativeFirstAuxiliaryVerb,
                          onChanged: (value) {
                            setState(() {
                              clause.options = clause.options.copyWith(collapseNegativeFirstAuxiliaryVerb: !clause.options.collapseNegativeFirstAuxiliaryVerb);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      if (!settingsOpen) ListTile(
                        title: Text.rich(TextSpan(
                          style: const TextStyle(fontSize: 13),
                          children: [
                            const TextSpan(
                              text: 'Tense: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: clause.options.tense.name,
                            ),
                            const TextSpan(
                              text: '\nClause type: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: clause.options.clauseType.name,
                            ),
                            const TextSpan(
                              text: '\nFirst auxiliary verb: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '${clause.options.modalVerb? 'Modal verb, ' : ''}'
                                  '${clause.options.affirmativeEmphasis? 'Affirmative emphasis, ' : ''}'
                                  '${clause.options.collapseFirstAuxiliaryVerb? 'Collapsed, ' : ''}'
                                  '${clause.options.collapseFirstAuxiliaryVerb? 'Collapse negative form ' : ''}'
                              ,
                            ),
                          ]
                        )),
                        leading: const Icon(Icons.settings),
                        trailing: const Icon(Icons.arrow_drop_down),
                        onTap: () {
                          setState(() {
                            settingsOpen = !settingsOpen;
                          });
                        },
                      ),
                      if (!settingsOpen) const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.adverb.color,
                        label: 'Front Adverb',
                        value: clauseMap['frontAdverb'],
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Subject',
                        value: clauseMap['subject'],
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectPage(
                                    subjectType: clause.options.subjectType,
                                    subject: clause.subject,
                                  )));
                          if (result is Subject) {
                            setState(() {
                              clause = clause.copyWith(subject: Nullable(result));
                            });
                          }
                        },
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'First Auxiliary Verb',
                        value: clauseMap['firstAuxiliaryVerb'],
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.adverb.color,
                        label: 'Middle Adverb',
                        value: clauseMap['middleAdverb'],
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'Second Auxiliary Verb',
                        value: clauseMap['secondAuxiliaryVerb'],
                        hide: clauseMap['secondAuxiliaryVerb'] == null,
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'Third Auxiliary Verb',
                        value: clauseMap['thirdAuxiliaryVerb'],
                        hide: clauseMap['thirdAuxiliaryVerb'] == null,
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.verb.color,
                        label: 'Verb',
                        value: clauseMap['verb'],
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Indirect Object',
                        value: clauseMap['indirectObject'],
                        hide: clauseMap['indirectObject'] == null,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Direct Object',
                        value: clauseMap['directObject'],
                        hide: clauseMap['directObject'] == null,
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      SentenceItemTile(
                        color: IndependentClausePartColor.noun.color,
                        label: 'Subject Complement',
                        value: clauseMap['subjectComplement'],
                        hide: clauseMap['subjectComplement'] == null,
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
}
