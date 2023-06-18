import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/sentence_cubit.dart';
import '../model/noun/pronoun.dart';
import '../model/verb/verb.dart';
import '../service/vocabulary_service.dart';
import 'common/autocomplete_word.dart';
import 'common/elevated_card.dart';

class VerbBuilder extends StatelessWidget {
  final Verb? verb;
  final void Function(Verb? verb) setVerb;

  VerbBuilder({super.key, required this.verb, required this.setVerb});

  @override
  Widget build(BuildContext context) {
    final clauseCubit = context.read<SentenceCubit>();
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Verb> verbs = vocabularyService.verbs();

    return ElevatedCard(
      children: [
        const ListTile(
          title: Text('Verb'),
          subtitle: Text('Verb'),
        ),
        AutocompleteWord<Verb>(
          label: 'Verb',
          value: verb,
          setValue: setVerb,
          options: verbs,
          valueToString: (verb) => verb.infinitive,
        )
      ],
    );
  }
}
