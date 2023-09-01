import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sentence_cubit.dart';
import '../../english_app.dart';
import '../../model/sentence.dart';
import '../independent_clause/independent_clause_builder.dart';
import '../common/item_button.dart';

class SentencePage extends StatefulWidget {
  SentencePage({super.key});

  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence'),
        actions: EnglishApp.globalActions,
      ),
      body: BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
        return ListView(
          children: [
            ListTile(
              title: Text(state.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            Card(
              child: ListTile(
                title: Text(state.independentClause.toString()),
                subtitle: const Text('Independent clause'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndependentClauseBuilder()));
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
