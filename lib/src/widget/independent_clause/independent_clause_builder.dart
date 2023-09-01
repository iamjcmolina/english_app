import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sentence_cubit.dart';
import '../../english_app.dart';
import '../../model/clause/clause_type.dart';
import '../../model/sentence.dart';
import '../../model/tense.dart';
import '../subject_builder.dart';
import '../verb_builder.dart';

class IndependentClauseBuilder extends StatefulWidget {
  IndependentClauseBuilder({super.key});

  @override
  State<IndependentClauseBuilder> createState() =>
      _IndependentClauseBuilderState();
}

class _IndependentClauseBuilderState extends State<IndependentClauseBuilder> {
  @override
  Widget build(BuildContext context) {
    final sentenceCubit = context.read<SentenceCubit>();

    return BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
      final clause = state.independentClause;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Independent Clause'),
          actions: EnglishApp.globalActions,
        ),
        body: Column(
          children: [
            ListTile(
              title: Text('${clause}'),
            ),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: Column(
                      children: [
                        if (false)
                          ListTile(
                            title: const Text('Undoubtedly'),
                            subtitle: const Text('Adverb'),
                            dense: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ListTile(
                          title: Text('${clause.validSubject}'),
                          subtitle: const Text('Subject'),
                          dense: true,
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectBuilder()));
                          },
                        ),
                        if (clause.firstAuxiliar != null)
                          ListTile(
                            title: Text(clause.firstAuxiliar!),
                            subtitle: Text('First Auxiliar verb'
                                '${clause.options.enableModalVerb ? ', Modal Verb' : clause.validVerb.isBe ? ', Verb "To BE"' : ''}'),
                            dense: true,
                            trailing: clause.options.enableModalVerb
                                ? const Icon(Icons.arrow_forward_ios)
                                : null,
                            onTap:
                                clause.options.enableModalVerb ? () {} : null,
                          ),
                        if (false)
                          ListTile(
                            title: const Text('always'),
                            subtitle: const Text('Adverb'),
                            dense: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        if (false)
                          ListTile(
                            title: const Text(''),
                            subtitle: const Text('Second Auxiliar verb'),
                            dense: true,
                          ),
                        if (false)
                          ListTile(
                            title: const Text(''),
                            subtitle: const Text('Third Auxiliar verb'),
                            dense: true,
                          ),
                        ListTile(
                          title: Text('${clause.validVerb}'),
                          subtitle: const Text('Verb'),
                          dense: true,
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerbBuilder(
                                          verb: clause.verb,
                                          setVerb: sentenceCubit.setVerb,
                                        )));
                          },
                        ),
                        if (clause.validVerb.isDitransitive)
                          ListTile(
                            title: Text('Indirect Object'),
                            dense: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                        if (clause.validVerb.isTransitive)
                          ListTile(
                            title: Text('Direct Object'),
                            dense: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                        if (clause.validVerb.isLinkingVerb)
                          ListTile(
                            title: Text('Subject complement'),
                            dense: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                        if (false)
                          ListTile(
                            title: const Text('here'),
                            subtitle: const Text('Adverb'),
                            dense: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.menu),
          onPressed: () {
            openBottomSheet(context);
          },
        ),
      );
    });
  }

  openBottomSheet(BuildContext context) {
    final sentenceCubit = context.read<SentenceCubit>();
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) =>
            BlocBuilder<SentenceCubit, Sentence>(builder: (context, state) {
              final clause = state.independentClause;
              return Column(
                children: [
                  const SizedBox(height: 20),
                  const ListTile(
                    title: Text('First Auxiliar Verb'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_day),
                    title: const Text('Modal Verb'),
                    dense: true,
                    trailing: Switch(
                      value: clause.options.enableModalVerb,
                      onChanged: (value) {
                        sentenceCubit.toggleModalVerb();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_day),
                    title: const Text('Affirmative emphasis'),
                    dense: true,
                    trailing: Switch(
                      value: clause.options.enableAffirmativeEmphasis,
                      onChanged: (value) {
                        sentenceCubit.toggleAffirmativeEmphasis();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.compress),
                    title: const Text('Contraction'),
                    dense: true,
                    trailing: Switch(
                      value: clause.options.enableContractions,
                      onChanged: (value) {
                        sentenceCubit.toggleContractions();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.compress),
                    title: const Text('Alternative contraction'),
                    dense: true,
                    trailing: Switch(
                      value: clause.options.enableSecondContractionToBe,
                      onChanged: (value) {
                        sentenceCubit.toggleAlternativeContractionToBeVerb();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tense'),
                        DropdownButton<Tense>(
                          value: clause.options.tense,
                          onChanged: (Tense? value) {
                            sentenceCubit.setTense(value!);
                          },
                          items: Tense.values
                              .map<DropdownMenuItem<Tense>>(
                                  (Tense item) => DropdownMenuItem<Tense>(
                                        value: item,
                                        child: Text(item.name),
                                      ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Clause type'),
                        DropdownButton<ClauseType>(
                          value: clause.options.type,
                          onChanged: (ClauseType? value) {
                            sentenceCubit.setClauseType(value!);
                          },
                          items: ClauseType.values
                              .map<DropdownMenuItem<ClauseType>>(
                                  (ClauseType item) =>
                                      DropdownMenuItem<ClauseType>(
                                        value: item,
                                        child: Text(item.name),
                                      ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Adverb'),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
