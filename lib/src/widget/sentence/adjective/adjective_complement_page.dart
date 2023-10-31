import 'package:flutter/material.dart';

import '../../../model/sentence/phrase/adjective_complement.dart';
import '../../../model/sentence/phrase/infinitive_phrase.dart';
import '../../../model/sentence/phrase/prepositional_phrase.dart';
import '../../../model/sentence/phrase/value/adjective_complement_type.dart';
import '../../sentence_scaffold.dart';
import '../phrase/infinitive_phrase_form.dart';
import '../phrase/prepositional_phrase_form.dart';

class AdjectiveComplementPage extends StatefulWidget {
  final AdjectiveComplement? complement;
  final bool isNegative;
  final bool isPlural;

  const AdjectiveComplementPage({
    super.key,
    required this.complement,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<AdjectiveComplementPage> createState() => _AdjectiveComplementPage();
}

class _AdjectiveComplementPage extends State<AdjectiveComplementPage> {
  late AdjectiveComplementType type;
  AdjectiveComplement? complement;
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    complement = widget.complement;
    canSave = complement != null;
    type = switch (complement.runtimeType) {
      PrepositionalPhrase => AdjectiveComplementType.prepositionalPhrase,
      _ => AdjectiveComplementType.infinitivePhrase,
    };
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: DropdownButton<AdjectiveComplementType>(
        value: type,
        onChanged: (AdjectiveComplementType? value) => setType(value!),
        items: AdjectiveComplementType.values
            .map<DropdownMenuItem<AdjectiveComplementType>>(
                (AdjectiveComplementType item) =>
                    DropdownMenuItem<AdjectiveComplementType>(
                      value: item,
                      child: Text(item.name),
                    ))
            .toList(),
      ),
    );

    return SentenceScaffold(
      title: 'Subject complement',
      bottomActions: [
        IconButton(
          onPressed: canSave ? () => Navigator.pop(context, complement) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        AdjectiveComplementType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setComplement,
            phrase: complement is InfinitivePhrase
                ? complement as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            setCanSave: setCanSave,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        AdjectiveComplementType.prepositionalPhrase => PrepositionalPhraseForm(
            setPhrase: setComplement,
            phrase: complement is PrepositionalPhrase
                ? complement as PrepositionalPhrase
                : const PrepositionalPhrase(),
            settingsControl: settingsControl,
            setCanSave: setCanSave,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
      },
    );
  }

  setComplement(AdjectiveComplement? complement) =>
      setState(() => this.complement = complement);

  setType(AdjectiveComplementType type) => setState(() => this.type = type);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);
}
