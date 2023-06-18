import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sentence_cubit.dart';
import '../model/clause/independent_clause.dart';
import '../model/noun/subject.dart';
import '../model/noun/subject_type.dart';
import '../model/sentence.dart';
import '../model/verb/empty_verb.dart';
import '../model/verb/verb.dart';
import '../service/vocabulary_service.dart';
import 'subject_builder.dart';
import 'verb_builder.dart';

class IndependentClauseBuilder extends StatelessWidget {
  final IndependentClause independentClause;
  final Function(IndependentClause) setIndependentClause;

  IndependentClauseBuilder({super.key, required this.independentClause, required this.setIndependentClause});

  @override
  Widget build(BuildContext context) {
    List<String> pronouns = VocabularyService.doers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('English Grammar'),
      ),
      body: BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
        return ListView(
          children: [
            Text(independentClause.toString()),
            ListTile(
              title: Text(state.independentClause.subject.toString()),
              subtitle: const Text('Subject'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectBuilder(
                  subjectType: independentClause.subjectType,
                  setSubjectType: setSubjectType,
                  subject: independentClause.subject,
                  setSubject: setSubject,
                )));
              },
            ),
            ListTile(
              title: Text(state.independentClause.verb.toString()),
              subtitle: const Text('Verb'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VerbBuilder(
                    verb: independentClause.verb,
                    setVerb: setVerb,
                )));
              },
            ),
          ],
        );
      }),
    );
  }

  void setSubjectType(SubjectType subjectType) {
    setIndependentClause(independentClause.copyWith(subjectType: subjectType));
  }

  void setSubject(Subject? subject) {
    setIndependentClause(independentClause.copyWith(subject: subject));
  }

  void setVerb(Verb? verb) {
    setIndependentClause(independentClause.copyWith(verb: verb ?? EmptyVerb()));
  }
}
