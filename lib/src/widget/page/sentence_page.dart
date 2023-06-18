import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sentence_cubit.dart';
import '../../model/sentence.dart';
import '../../widget/independent_clause_builder.dart';

class SentencePage extends StatelessWidget {
  SentencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sentenceCubit = context.read<SentenceCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('English Grammar'),
      ),
      body: BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
        return ListView(
          children: [
            Text(state.toString()),
            ListTile(
              title: Text(state.independentClause.toString()),
              subtitle: const Text('Independent clause'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => IndependentClauseBuilder(
                  independentClause: state.independentClause,
                  setIndependentClause: sentenceCubit.setIndependentClause,
                )));
              },
            ),
          ],
        );
      }),
    );
  }
}
