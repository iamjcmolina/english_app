import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sentence_cubit.dart';
import '../model/clause/clause_type.dart';
import '../model/sentence.dart';
import '../model/tense.dart';
import 'common/filled_card.dart';
import 'common/outlined_card.dart';
import 'subject_builder.dart';
import 'verb_builder.dart';

class IndependentClauseBuilder extends StatefulWidget {
  IndependentClauseBuilder({super.key});

  @override
  State<IndependentClauseBuilder> createState() => _IndependentClauseBuilderState();
}

class _IndependentClauseBuilderState extends State<IndependentClauseBuilder> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    final sentenceCubit = context.read<SentenceCubit>();

    return BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Independent Clause'),
      ),
      body: ListView(
          children: [
            ListTile(
              title: Text(state.independentClause.toString()),
              subtitle: const Text('Independent clause'),
            ),
            OutlinedCard(
              children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Options'),
                    trailing: Icon(showOptions? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined),
                    onTap: () { setState(() { showOptions = !showOptions; }); },
                  ),
                   if(showOptions) ListTile(
                    title: const Text('Contractions'),
                    dense: true,
                    trailing: Switch(
                      value: state.independentClause.enableContractions,
                      onChanged: (value) {
                        sentenceCubit.toggleContractions();
                      },
                    ),
                  ),
                if(showOptions)ListTile(
                    title: const Text('Alternative contraction for to be verb'),
                    dense: true,
                    trailing: Switch(
                      value: state.independentClause.enableSecondContractionToBe,
                      onChanged: (value) {
                        sentenceCubit.toggleAlternativeContractionToBeVerb();
                      },
                    ),
                  ),
                if(showOptions) ListTile(
                    title: const Text('Affirmative emphasis'),
                    dense: true,
                    trailing: Switch(
                      value: state.independentClause.enableAffirmativeEmphasis,
                      onChanged: (value) {
                        sentenceCubit.toggleAffirmativeEmphasis();
                      },
                    ),
                  ),
                if(showOptions) Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tense'),
                        DropdownButton<Tense>(
                          value: state.independentClause.tense,
                          onChanged: (Tense? value) {
                            sentenceCubit.setTense(value!);
                          },
                          items: Tense.values.map<DropdownMenuItem<Tense>>((Tense item) =>
                              DropdownMenuItem<Tense>(
                                value: item,
                                child: Text(item.name),
                              )
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                if(showOptions) Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Clause type'),
                        DropdownButton<ClauseType>(
                          value: state.independentClause.type,
                          onChanged: (ClauseType? value) {
                            sentenceCubit.setClauseType(value!);
                          },
                          items: ClauseType.values.map<DropdownMenuItem<ClauseType>>((ClauseType item) =>
                              DropdownMenuItem<ClauseType>(
                                value: item,
                                child: Text(item.name),
                              )
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ],

            ),
            Card(
              child: ListTile(
                title: const Text('<Adverb>'),
                subtitle: const Text('Adverb'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('${state.independentClause.validSubject}'),
                subtitle: const Text('Subject'),
                dense: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectBuilder()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('<Modal verb>'),
                subtitle: const Text('Modal verb'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('<Adverb>'),
                subtitle: const Text('Adverb'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('${state.independentClause.validVerb}'),
                subtitle: const Text('Verb'),
                dense: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerbBuilder(
                    verb: state.independentClause.verb,
                    setVerb: sentenceCubit.setVerb,
                  )));
                },
              ),
            ),
            if (state.independentClause.validVerb.isDitransitive) Card(
              child: ListTile(
                title: Text('<Indirect Object>'),
                subtitle: const Text('Indirect Object'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
            if (state.independentClause.validVerb.isTransitive) Card(
              child: ListTile(
                title: Text('<Direct object>'),
                subtitle: const Text('Direct object'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
            if (state.independentClause.validVerb.isLinkingVerb) Card(
              child: ListTile(
                title: Text('<Subject complement>'),
                subtitle: const Text('Subject complement'),
                dense: true,
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('<Adverbs>'),
                subtitle: const Text('Adverbs'),
                dense: true,
                enabled: false,
                trailing: Switch(value: false, onChanged: (bool value) {  },),
                onTap: () {
                },
              ),
            ),
          ],
        )
      );
    });
  }
}
