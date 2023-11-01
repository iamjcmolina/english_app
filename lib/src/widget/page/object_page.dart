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
  late NounType nounType;

  bool get isValid => object?.isValid ?? false;

  bool get mustAllowPronouns =>
      !widget.isDitransitiveVerb || widget.isIndirectObject;

  @override
  void initState() {
    super.initState();
    object = widget.object;
    nounType = object == null
        ? (mustAllowPronouns ? NounType.pronoun : NounType.nounPhrase)
        : switch (object.runtimeType) {
            NounPhrase => NounType.nounPhrase,
            IndefinitePronoun => NounType.indefinitePronoun,
            _ => NounType.pronoun,
          };
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    List<Pronoun> pronouns = vocabularyRepository.objectPronouns();

    final settingsControl = Center(
      child: DropdownButton<NounType>(
        value: nounType,
        onChanged: (NounType? value) => setNounType(value!),
        items: NounType.values
            .where((e) => mustAllowPronouns ? true : e != NounType.pronoun)
            .map<DropdownMenuItem<NounType>>(
                (NounType item) => DropdownMenuItem<NounType>(
                      value: item,
                      child: Text(item.name),
                    ))
            .toList(),
      ),
    );

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
      body: switch (nounType) {
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
            pronouns: pronouns,
            setPronoun: setObject,
            pronoun: object is Pronoun ? object as Pronoun : null,
            settingsControl: settingsControl,
          ),
      },
    );
  }

  setObject(AnyNoun? object) => setState(() => this.object = object);

  setNounType(NounType type) => setState(() => nounType = type);
}
