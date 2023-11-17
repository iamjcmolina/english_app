import 'package:flutter/material.dart';

import '../../model/sentence/noun/any_noun.dart';
import '../../model/sentence/noun/indefinite_pronoun.dart';
import '../../model/sentence/noun/object_pronoun.dart';
import '../../model/sentence/noun/object_type.dart';
import '../../model/sentence/phrase/gerund_phrase.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/noun_phrase.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/noun/indefinite_pronoun_form.dart';
import '../sentence/noun/object_pronoun_form.dart';
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
  late ObjectType type;

  bool get isValid => object?.isValid ?? false;

  bool get mustAllowPronouns =>
      !widget.isDitransitiveVerb || widget.isIndirectObject;

  @override
  void initState() {
    super.initState();
    object = widget.object;
    type = type = ObjectType.from(object.runtimeType,
        mustAllowPronouns ? ObjectType.pronoun : ObjectType.nounPhrase);
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<ObjectType>(
                label: const Text('Noun Object Type'),
                initialSelection: type,
                dropdownMenuEntries: ObjectType.values
                    .where((e) => mustAllowPronouns || e != ObjectType.pronoun)
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
        ObjectType.pronoun => ObjectPronounForm(
            setPronoun: setObject,
            pronoun: object is ObjectPronoun ? object as ObjectPronoun : null,
            settingsControl: settingsControl,
          ),
        ObjectType.nounPhrase => NounPhraseForm(
            setPhrase: setObject,
            phrase: object is NounPhrase
                ? object as NounPhrase
                : const NounPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        ObjectType.indefinitePronoun => IndefinitePronounForm(
            setPronoun: setObject,
            pronoun: object is IndefinitePronoun
                ? object as IndefinitePronoun
                : null,
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
          ),
        ObjectType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setObject,
            phrase: object is InfinitivePhrase
                ? object as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        ObjectType.gerundPhrase => GerundPhraseForm(
            setPhrase: setObject,
            phrase: object is GerundPhrase
                ? object as GerundPhrase
                : const GerundPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
      },
    );
  }

  setObject(AnyNoun? object) => setState(() => this.object = object);

  setType(ObjectType type) => setState(() => this.type = type);
}
