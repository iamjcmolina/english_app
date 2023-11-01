import 'package:flutter/material.dart';

import '../../model/sentence/adverb/adverb.dart';
import '../../model/sentence/adverb/adverb_position.dart';
import '../../model/sentence/adverb/adverb_variant.dart';
import '../../model/sentence/adverb/any_adverb.dart';
import '../../model/sentence/phrase/adverb_plus_adverb.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/prepositional_phrase.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/adverb/adverb_form.dart';
import '../sentence/phrase/adverb_plus_adverb_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/prepositional_phrase_form.dart';

class AdverbPage extends StatefulWidget {
  final AdverbPosition position;
  final AnyAdverb? adverb;
  final bool isNegative;
  final bool isPlural;

  const AdverbPage({
    super.key,
    required this.position,
    required this.adverb,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<AdverbPage> createState() => _AdverbPageState();
}

class _AdverbPageState extends State<AdverbPage> {
  AnyAdverb? adverb;
  late AdverbVariant variant;

  bool get isValid => adverb?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    adverb = widget.adverb;
    variant = switch (widget.adverb.runtimeType) {
      _ => AdverbVariant.word,
    };
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<AdverbVariant>(
          initialSelection: variant,
          label: const Text('Adverb Variant'),
          dropdownMenuEntries: AdverbVariant.values
              .map<DropdownMenuEntry<AdverbVariant>>(
                  (AdverbVariant item) => DropdownMenuEntry<AdverbVariant>(
                        value: item,
                        label: item.name,
                      ))
              .toList(),
          onSelected: (AdverbVariant? item) => setVariant(item!),
        ),
      ),
    );

    return SentenceScaffold(
        title: 'Independent Clause',
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
        body: switch (variant) {
          AdverbVariant.adverbPlusAdverb => AdverbPlusAdverbForm(
              setPhrase: setAdverb,
              phrase: adverb is AdverbPlusAdverb
                  ? adverb as AdverbPlusAdverb
                  : const AdverbPlusAdverb(),
              settingsControl: settingsControl,
            ),
          AdverbVariant.infinitivePhrase => InfinitivePhraseForm(
              setPhrase: setAdverb,
              phrase: adverb is InfinitivePhrase
                  ? adverb as InfinitivePhrase
                  : const InfinitivePhrase(),
              settingsControl: settingsControl,
              isNegative: widget.isNegative,
              isPlural: widget.isPlural,
            ),
          AdverbVariant.prepositionalPhrase => PrepositionalPhraseForm(
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

  setVariant(AdverbVariant variant) => setState(() => this.variant = variant);
}
