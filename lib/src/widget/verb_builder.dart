import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/sentence_cubit.dart';
import '../model/noun/pronoun.dart';
import '../model/verb/verb.dart';
import '../service/vocabulary_service.dart';
import 'common/autocomplete_word.dart';
import 'common/elevated_card.dart';

class VerbBuilder extends StatefulWidget {
  final Verb? verb;
  final void Function(Verb? verb) setVerb;

  VerbBuilder({super.key, required this.verb, required this.setVerb});

  @override
  State<VerbBuilder> createState() => _VerbBuilderState();
}

class _VerbBuilderState extends State<VerbBuilder> {
  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Verb> verbs = vocabularyService.verbs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('<Verb>')
          ),
          Card(
              child: AutocompleteWord<Verb>(
                label: 'Verb',
                value: widget.verb,
                setValue: widget.setVerb,
                options: verbs,
                valueToString: (verb) => verb.infinitive,
                captionWhenNull: '<Verb>',
              )
          ),
        ],
      )
    );
  }
}
