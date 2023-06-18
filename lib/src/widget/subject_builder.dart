import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/noun/pronoun.dart';
import '../model/noun/subject.dart';
import '../model/noun/subject_type.dart';
import '../service/vocabulary_service.dart';
import 'common/elevated_card.dart';
import 'pronoun_builder.dart';

class SubjectBuilder extends StatelessWidget {
  final SubjectType subjectType;
  final void Function(SubjectType) setSubjectType;
  final Subject? subject;
  final void Function(Subject?) setSubject;

  SubjectBuilder({
    super.key,
    required this.subjectType,
    required this.setSubjectType,
    required this.subject,
    required this.setSubject,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Pronoun> pronouns = vocabularyService.subjectPronouns();

    return ElevatedCard(
      children: [
        ListTile(
          dense: true,
          leading: Checkbox(value: true, onChanged: (x){}),
          title: Text(subjectType.name),
          subtitle: const Text('Subject'),
          trailing: PopupMenuButton<SubjectType>(
            offset: const Offset(0, 400),
              onSelected: (SubjectType? value) {
                setSubjectType(value!);
              },
              itemBuilder: (BuildContext context) =>
                  SubjectType.values.map<PopupMenuEntry<SubjectType>>(
                          (SubjectType nounType) =>
                          PopupMenuItem<SubjectType>(
                            value: nounType,
                            child: Text(nounType.name),
                          )
                  ).toList(),
            ),
        ),
        if (subjectType == SubjectType.pronoun)
          PronounBuilder(
            pronoun: subject is Pronoun? subject as Pronoun : null,
            setPronoun: setSubject,
            pronouns: pronouns,
          ),
      ],
    );
  }
}
