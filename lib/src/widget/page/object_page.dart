import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/sentence/noun/any_noun.dart';
import '../../model/sentence/noun/indefinite_pronoun.dart';
import '../../model/sentence/noun/noun_type.dart';
import '../../model/sentence/noun/pronoun.dart';
import '../../model/sentence/phrase/gerund_phrase.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/noun_phrase.dart';
import '../../repository/vocabulary_repository.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/noun/indefinite_pronoun_form.dart';
import '../sentence/noun/pronoun_form.dart';
import '../sentence/phrase/gerund_phrase_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/noun_phrase_form.dart';

class ObjectPage extends StatefulWidget {
  final AnyNoun? object;
  final bool isIndirectObject;
  final bool isDitransitiveVerb;
  final bool isNegative;
  final bool isPlural;

  const ObjectPage({
    super.key,
    required this.object,
    required this.isIndirectObject,
    required this.isDitransitiveVerb,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<ObjectPage> createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  AnyNoun? object;
  late NounType type;

  bool get isValid => object?.isValid ?? false;

  bool get mustAllowPronouns =>
      !widget.isDitransitiveVerb || widget.isIndirectObject;

  @override
  void initState() {
    super.initState();
    object = widget.object;
    type = type = NounType.from(object.runtimeType,
        mustAllowPronouns ? NounType.pronoun : NounType.nounPhrase);
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    final settingsControl = Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<NounType>(
                label: const Text('Noun Object Type'),
                initialSelection: type,
                dropdownMenuEntries: NounType.values
                    .where((e) => mustAllowPronouns || e != NounType.pronoun)
                    .map((e) => DropdownMenuEntry(value: e, label: e.name))
                    .toList(),
                onSelected: (e) => setType(e!))));

    return SentenceScaffold(
      title: widget.isIndirectObject ? 'Indirect Object' : 'Direct Object',
      bottomActions: [
        IconButton(
          onPressed: isValid ? () => Navigator.pop(context, object) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        NounType.nounPhrase => NounPhraseForm(
            setPhrase: setObject,
            phrase: object is NounPhrase
                ? object as NounPhrase
                : const NounPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        NounType.indefinitePronoun => IndefinitePronounForm(
            setPronoun: setObject,
            pronoun: object is IndefinitePronoun
                ? object as IndefinitePronoun
                : null,
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
          ),
        NounType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setObject,
            phrase: object is InfinitivePhrase
                ? object as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        NounType.gerundPhrase => GerundPhraseForm(
            setPhrase: setObject,
            phrase: object is GerundPhrase
                ? object as GerundPhrase
                : const GerundPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        _ => PronounForm(
            pronouns: vocabularyRepository.objectPronouns(),
            setPronoun: setObject,
            pronoun: object is Pronoun ? object as Pronoun : null,
            settingsControl: settingsControl,
          ),
      },
    );
  }

  setObject(AnyNoun? object) => setState(() => this.object = object);

  setType(NounType type) => setState(() => this.type = type);
}
