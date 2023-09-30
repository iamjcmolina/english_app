import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/sentence/noun/value/subject_type.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../service/vocabulary_service.dart';
import '../../root_layout.dart';
import 'noun_phrase_form.dart';
import 'pronoun_form.dart';

class SubjectPage extends StatefulWidget {
  final SubjectType subjectType;
  final AnyNoun? subject;

  const SubjectPage({super.key, required this.subjectType, this.subject});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  late SubjectType subjectType;
  AnyNoun? subject;
  bool showBottomAppBar = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Pronoun> pronouns = vocabularyService.subjectPronouns();

    return RootLayout(
      title: 'Subject',
      showBottomAppBar: showBottomAppBar,
      bottomAppBarChildren: [
        IconButton(
          onPressed: () => Navigator.pop(context, subject),
          icon: const Icon(Icons.save)
        ),
      ],
      header: Column(
        children: [
          Center(
            child: DropdownButton<SubjectType>(
              value: subjectType,
              onChanged: (SubjectType? value) => setSubjectType(value!),
              items: SubjectType.values.map<DropdownMenuItem<SubjectType>>(
                      (SubjectType item) => DropdownMenuItem<SubjectType>(
                    value: item,
                    child: Text(item.name),
                  )
              ).toList(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (subjectType == SubjectType.pronoun)
            PronounForm(
                pronouns: pronouns,
                setPronoun: setSubject,
                pronoun: subject is Pronoun? subject as Pronoun : null,
                setShowBottomAppBar: setShowBottomAppBar
            ),
          if (subjectType == SubjectType.nounPhrase)
            NounPhraseForm(
              setNounPhrase: setSubject,
              nounPhrase: subject is NounPhrase? subject as NounPhrase : null,
            ),
        ],
      ),
    );
  }

  setSubject(AnyNoun? subject) => setState(() => this.subject = subject);

  setSubjectType(SubjectType type) => setState(() => subjectType = type);

  setShowBottomAppBar(bool show) => setState(() => showBottomAppBar = show);

  @override
  void initState() {
    super.initState();
    subjectType = widget.subjectType;
    subject = widget.subject;
    showBottomAppBar = subject != null;
  }
}
