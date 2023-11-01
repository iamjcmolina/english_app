import 'package:flutter/material.dart';

import '../../model/sentence/adjective/any_adjective.dart';
import '../../model/sentence/phrase/adjectival_phrase_type.dart';
import '../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../model/sentence/phrase/adverb_plus_adjective.dart';
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

class AdjectivalPhrasePage extends StatefulWidget {
  final AnyAdjective? adjective;
  final bool isNegative;
  final bool isPlural;

  const AdjectivalPhrasePage({
    super.key,
    required this.adjective,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<AdjectivalPhrasePage> createState() => _AdjectivalPhrasePageState();
}

class _AdjectivalPhrasePageState extends State<AdjectivalPhrasePage> {
  AnyAdjective? adjective;
  late AdjectivalPhraseType type;

  bool get isValid => adjective?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    adjective = widget.adjective;
    type = AdjectivalPhraseType.prepositionalPhrase;
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<AdjectivalPhraseType>(
          label: const Text('Adjectival Phrase Type'),
          initialSelection: type,
          dropdownMenuEntries: AdjectivalPhraseType.values
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
          onSelected: (e) => setType(e!),
        ),
      ),
    );

    return SentenceScaffold(
      title: 'Adjectival Phrase',
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
        AdjectivalPhraseType.prepositionalPhrase => PrepositionalPhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PrepositionalPhrase
                ? adjective as PrepositionalPhrase
                : const PrepositionalPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        AdjectivalPhraseType.presentParticiplePhrase =>
          PresentParticiplePhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PresentParticiplePhrase
                ? adjective as PresentParticiplePhrase
                : const PresentParticiplePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        AdjectivalPhraseType.pastParticiplePhrase => PastParticiplePhraseForm(
            setPhrase: setAdjective,
            phrase: adjective is PastParticiplePhrase
                ? adjective as PastParticiplePhrase
                : const PastParticiplePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        AdjectivalPhraseType.adverbPlusAdjective => AdverbPlusAdjectiveForm(
            setPhrase: setAdjective,
            phrase: adjective is AdverbPlusAdjective
                ? adjective as AdverbPlusAdjective
                : const AdverbPlusAdjective(),
            settingsControl: settingsControl,
            isPlural: widget.isPlural,
          ),
        AdjectivalPhraseType.adjectivePlusComplement =>
          AdjectivePlusComplementForm(
            setPhrase: setAdjective,
            phrase: adjective is AdjectivePlusComplement
                ? adjective as AdjectivePlusComplement
                : const AdjectivePlusComplement(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        AdjectivalPhraseType.infinitivePhrase => InfinitivePhraseForm(
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

  setType(AdjectivalPhraseType type) => setState(() => this.type = type);
}
