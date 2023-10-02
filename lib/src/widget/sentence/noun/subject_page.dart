import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/sentence/noun/value/subject_type.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../service/vocabulary_service.dart';
import '../../sentence_scaffold.dart';
import 'noun_phrase_form.dart';
import 'pronoun_form.dart';

class SubjectPage extends StatefulWidget {
  final AnyNoun? subject;

  const SubjectPage({super.key, required this.subject});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  late SubjectType subjectType;
  AnyNoun? subject;
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    subject = widget.subject;
    canSave = subject != null;
    subjectType = switch(widget.subject.runtimeType) {
      NounPhrase => SubjectType.nounPhrase,
      _ => SubjectType.pronoun,
    };
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Pronoun> pronouns = vocabularyService.subjectPronouns();

    final settingsControl = Center(
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
    );

    return SentenceScaffold(
      title: 'Subject',
      bottomActions: [
        IconButton(
          onPressed: canSave? () => Navigator.pop(context, subject) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.clear),
        ),
      ],
      body: switch(subjectType) {
        SubjectType.nounPhrase => NounPhraseForm(
          setNounPhrase: setSubject,
          nounPhrase: subject is NounPhrase? subject as NounPhrase : null,
          settingsControl: settingsControl,
          setCanSave: setCanSave,
        ),
        _ => PronounForm(
          pronouns: pronouns,
          setPronoun: setSubject,
          pronoun: subject is Pronoun? subject as Pronoun : null,
          setCanSave: setCanSave,
          settingsControl: settingsControl,
        ),
      },
    );
  }

  setSubject(AnyNoun? subject) => setState(() => this.subject = subject);

  setSubjectType(SubjectType type) => setState(() => subjectType = type);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);
}
