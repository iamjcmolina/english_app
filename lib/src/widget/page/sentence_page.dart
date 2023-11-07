import 'package:flutter/material.dart';

import '../../model/sentence/clause/independent_clause.dart';
import '../../model/sentence/sentence.dart';
import '../common/sentence_scaffold.dart';
import 'independent_clause_page.dart';

class SentencePage extends StatefulWidget {
  const SentencePage({super.key});

  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  Sentence sentence = const Sentence(independentClause: IndependentClause());

  @override
  Widget build(BuildContext context) {
    return SentenceScaffold(
      title: 'Sentence',
      body: Column(
        children: [
          ListTile(
            title: Text(sentence.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
                          ));
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
