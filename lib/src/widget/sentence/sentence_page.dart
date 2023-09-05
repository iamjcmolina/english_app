import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../english_app.dart';
import '../../model/sentence/clause/independent_clause.dart';
import '../../model/sentence/sentence.dart';
import 'clause/independent_clause_page.dart';

class SentenceBuilder extends StatefulWidget {
  SentenceBuilder({super.key});

  @override
  State<SentenceBuilder> createState() => _SentenceBuilderState();
}

class _SentenceBuilderState extends State<SentenceBuilder> {
  // late Sentence sentence;
  Sentence sentence = Sentence(
      independentClause: IndependentClause(
        // options: IndependentClauseOptions(),
        // subject: UndefinedSubject(), // logic
        // verb: UndefinedVerb(), // logic
        // modalVerb: UndefinedModalVerb(), // logic
        // indirectObject: UndefinedIndirectObject(),
        // directObject: UndefinedDirectObject(),
        // subjectComplement: UndefinedSubjectComplement(),
      )
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence'),
        actions: EnglishApp.globalActions,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(sentence.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text(sentence.independentClause.toString()),
                    subtitle: const Text('Independent clause'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndependentClausePage(
                                clause: sentence.independentClause,
                              ),
                          )
                      );
                    },
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
