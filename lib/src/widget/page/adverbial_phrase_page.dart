import 'package:flutter/material.dart';

import '../../model/sentence/adverb/adverb.dart';
import '../../model/sentence/adverb/adverb_position.dart';
import '../../model/sentence/adverb/adverbial_phrase_type.dart';
import '../../model/sentence/adverb/any_adverb.dart';
import '../../model/sentence/phrase/adverb_plus_adverb.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/prepositional_phrase.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/adverb/adverb_form.dart';
import '../sentence/phrase/adverb_plus_adverb_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/prepositional_phrase_form.dart';

class AdverbialPhrasePage extends StatefulWidget {
  final AdverbPosition position;
  final AnyAdverb? adverb;
  final bool isNegative;
  final bool isPlural;

  const AdverbialPhrasePage({
    super.key,
    required this.position,
    required this.adverb,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<AdverbialPhrasePage> createState() => _AdverbialPhrasePageState();
}

class _AdverbialPhrasePageState extends State<AdverbialPhrasePage> {
  AnyAdverb? adverb;
  late AdverbialPhraseType type;

  bool get isValid => adverb?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    adverb = widget.adverb;
    type = AdverbialPhraseType.from(
        adverb.runtimeType, AdverbialPhraseType.adverb);
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<AdverbialPhraseType>(
          label: const Text('Adverbial Phrase Type'),
          initialSelection: type,
          dropdownMenuEntries: AdverbialPhraseType.values
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
          onSelected: (e) => setType(e!),
        ),
      ),
    );

    return SentenceScaffold(
        title: 'Adverb',
        bottomActions: [
          IconButton(
            onPressed: isValid ? () => Navigator.pop(context, adverb) : null,
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.clear),
          ),
        ],
        body: switch (type) {
          AdverbialPhraseType.adverbPlusAdverb => AdverbPlusAdverbForm(
              setPhrase: setAdverb,
              phrase: adverb is AdverbPlusAdverb
                  ? adverb as AdverbPlusAdverb
                  : const AdverbPlusAdverb(),
              settingsControl: settingsControl,
            ),
          AdverbialPhraseType.infinitivePhrase => InfinitivePhraseForm(
              setPhrase: setAdverb,
              phrase: adverb is InfinitivePhrase
                  ? adverb as InfinitivePhrase
                  : const InfinitivePhrase(),
              settingsControl: settingsControl,
              isNegative: widget.isNegative,
              isPlural: widget.isPlural,
            ),
          AdverbialPhraseType.prepositionalPhrase => PrepositionalPhraseForm(
              setPhrase: setAdverb,
              phrase: adverb is PrepositionalPhrase
                  ? adverb as PrepositionalPhrase
                  : const PrepositionalPhrase(),
              settingsControl: settingsControl,
              isNegative: widget.isNegative,
              isPlural: widget.isPlural,
            ),
          _ => AdverbForm(
              settingsControl: settingsControl,
              position: widget.position,
              adverb: adverb is Adverb ? adverb as Adverb : null,
              setAdverb: setAdverb,
            ),
        });
  }

  setAdverb(AnyAdverb? adverb) => setState(() => this.adverb = adverb);

  setType(AdverbialPhraseType type) => setState(() => this.type = type);
}
