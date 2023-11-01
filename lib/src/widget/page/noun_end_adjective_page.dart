import 'package:flutter/material.dart';

import '../../model/sentence/adjective/any_adjective.dart';
import '../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../model/sentence/phrase/adverb_plus_adjective.dart';
import '../../model/sentence/phrase/end_adjective_type.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/past_participle_phrase.dart';
import '../../model/sentence/phrase/prepositional_phrase.dart';
import '../../model/sentence/phrase/present_participle_phrase.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/phrase/adjective_plus_complement_form.dart';
import '../sentence/phrase/adverb_plus_adjective_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/past_participle_phrase_form.dart';
import '../sentence/phrase/prepositional_phrase_form.dart';
import '../sentence/phrase/present_participle_phrase_form.dart';

class NounEndAdjectivePage extends StatefulWidget {
  final AnyAdjective? adjective;
  final bool isNegative;
  final bool isPlural;

  const NounEndAdjectivePage({
    super.key,
    required this.adjective,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<NounEndAdjectivePage> createState() => _NounEndAdjectivePageState();
}

class _NounEndAdjectivePageState extends State<NounEndAdjectivePage> {
  EndAdjectiveType type = EndAdjectiveType.prepositionalPhrase;
  AnyAdjective? adjective;

  bool get isValid => adjective?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    adjective = widget.adjective;
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: DropdownButton<EndAdjectiveType>(
        value: type,
        onChanged: (EndAdjectiveType? value) => setEndAdjectiveType(value!),
        items: EndAdjectiveType.values
            .map<DropdownMenuItem<EndAdjectiveType>>(
                (EndAdjectiveType item) => DropdownMenuItem<EndAdjectiveType>(
                      value: item,
                      child: Text(item.name),
                    ))
            .toList(),
      ),
    );

    return SentenceScaffold(
      title: 'Post Modifier (Adjective Phrase)',
      bottomActions: [
        IconButton(
          onPressed: isValid ? () => Navigator.pop(context, adjective) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        EndAdjectiveType.prepositionalPhrase => PrepositionalPhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PrepositionalPhrase
                ? adjective as PrepositionalPhrase
                : const PrepositionalPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        EndAdjectiveType.presentParticiplePhrase => PresentParticiplePhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PresentParticiplePhrase
                ? adjective as PresentParticiplePhrase
                : const PresentParticiplePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        EndAdjectiveType.pastParticiplePhrase => PastParticiplePhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PastParticiplePhrase
                ? adjective as PastParticiplePhrase
                : const PastParticiplePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        EndAdjectiveType.adverbPlusAdjective => AdverbPlusAdjectiveForm(
            setPhrase: setAdjective,
            phrase: adjective is AdverbPlusAdjective
                ? adjective as AdverbPlusAdjective
                : const AdverbPlusAdjective(),
            settingsControl: settingsControl,
            isPlural: widget.isPlural,
          ),
        EndAdjectiveType.adjectivePlusComplement => AdjectivePlusComplementForm(
            setPhrase: setAdjective,
            phrase: adjective is AdjectivePlusComplement
                ? adjective as AdjectivePlusComplement
                : const AdjectivePlusComplement(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        EndAdjectiveType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is InfinitivePhrase
                ? adjective as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
      },
    );
  }

  setAdjective(AnyAdjective? adjective) =>
      setState(() => this.adjective = adjective);

  setEndAdjectiveType(EndAdjectiveType type) =>
      setState(() => this.type = type);
}
