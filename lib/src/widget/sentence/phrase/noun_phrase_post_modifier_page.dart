import 'package:flutter/material.dart';

import '../../../model/sentence/adjective/any_adjective.dart';
import '../../../model/sentence/phrase/infinitive_phrase.dart';
import '../../../model/sentence/phrase/prepositional_phrase.dart';
import '../../../model/sentence/phrase/present_participle_phrase.dart';
import '../../../model/sentence/phrase/value/noun_phrase_post_modifier_type.dart';
import '../../sentence_scaffold.dart';
import '../phrase/infinitive_phrase_form.dart';
import 'prepositional_phrase_form.dart';
import 'present_participle_phrase_form.dart';

class NounPhrasePostModifierPage extends StatefulWidget {
  final AnyAdjective? modifier;
  final bool isNegative;

  const NounPhrasePostModifierPage({
    super.key,
    required this.modifier,
    required this.isNegative,
  });

  @override
  State<NounPhrasePostModifierPage> createState() =>
      _NounPhrasePostModifierPageState();
}

class _NounPhrasePostModifierPageState
    extends State<NounPhrasePostModifierPage> {
  NounPhrasePostModifierType modifierType =
      NounPhrasePostModifierType.prepositionalPhrase;
  AnyAdjective? modifier;
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    modifier = widget.modifier;
    canSave = modifier != null;
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: DropdownButton<NounPhrasePostModifierType>(
        value: modifierType,
        onChanged: (NounPhrasePostModifierType? value) =>
            setModifierType(value!),
        items: NounPhrasePostModifierType.values
            .map<DropdownMenuItem<NounPhrasePostModifierType>>(
                (NounPhrasePostModifierType item) =>
                    DropdownMenuItem<NounPhrasePostModifierType>(
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
          onPressed: canSave ? () => Navigator.pop(context, modifier) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (modifierType) {
        NounPhrasePostModifierType.prepositionalPhrase =>
          PrepositionalPhraseForm(
            setPhrase: setModifier,
            phrase: modifier is PrepositionalPhrase
                ? modifier as PrepositionalPhrase
                : const PrepositionalPhrase(),
            settingsControl: settingsControl,
            setCanSave: setCanSave,
            isNegative: widget.isNegative,
          ),
        NounPhrasePostModifierType.presentParticiplePhrase =>
          PresentParticiplePhraseForm(
            setPhrase: setModifier,
            phrase: modifier is PresentParticiplePhrase
                ? modifier as PresentParticiplePhrase
                : const PresentParticiplePhrase(),
            settingsControl: settingsControl,
            setCanSave: setCanSave,
            isNegative: widget.isNegative,
          ),
        NounPhrasePostModifierType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setModifier,
            phrase: modifier is InfinitivePhrase
                ? modifier as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            setCanSave: setCanSave,
            isNegative: widget.isNegative,
          ),
      },
    );
  }

  setModifier(AnyAdjective? modifier) =>
      setState(() => this.modifier = modifier);

  setModifierType(NounPhrasePostModifierType type) =>
      setState(() => modifierType = type);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);
}
