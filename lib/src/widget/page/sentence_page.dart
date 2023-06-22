import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sentence_cubit.dart';
import '../../model/sentence.dart';
import '../../widget/independent_clause_builder.dart';

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
      ),
      body: BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
        return ListView(
          children: [
            Card(
                child: ListTile(
                  title: Text(state.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                )
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
