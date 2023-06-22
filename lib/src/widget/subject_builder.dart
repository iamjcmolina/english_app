import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/sentence_cubit.dart';
import '../model/noun/pronoun.dart';
import '../model/noun/subject_type.dart';
import '../model/sentence.dart';
import '../service/vocabulary_service.dart';
import 'pronoun_builder.dart';

class SubjectBuilder extends StatelessWidget {
  SubjectBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final sentenceCubit = context.read<SentenceCubit>();
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Pronoun> pronouns = vocabularyService.subjectPronouns();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject'),
      ),
      body: BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
        return ListView(
          children: [
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Subject Type'),
                  ),
                  DropdownButton<SubjectType>(
                    value: state.independentClause.subjectType,
                    onChanged: (SubjectType? value) {
                      sentenceCubit.setSubjectType(value!);
                    },
                    items: SubjectType.values.map<DropdownMenuItem<SubjectType>>((SubjectType item) =>
                        DropdownMenuItem<SubjectType>(
                          value: item,
                          child: Text(item.name),
                        )
                    ).toList(),
                  ),
                ],
              ),
            ),
            if (state.independentClause.subjectType == SubjectType.pronoun)
              Card(
                child: PronounBuilder(
                  pronoun: state.independentClause.subject is Pronoun? state.independentClause.subject as Pronoun : null,
                  setPronoun: sentenceCubit.setSubject,
                  pronouns: pronouns,
                ),
              ),
          ],
        );
      }),
    );
  }
}
