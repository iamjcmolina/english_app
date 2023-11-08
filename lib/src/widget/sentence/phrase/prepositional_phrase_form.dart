import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/prepositional_phrase.dart';
import '../../../model/sentence/preposition/preposition.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import '../../page/object_page.dart';

class PrepositionalPhraseForm extends StatefulWidget {
  final Widget settingsControl;
  final PrepositionalPhrase phrase;
  final void Function(PrepositionalPhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const PrepositionalPhraseForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<PrepositionalPhraseForm> createState() =>
      _PrepositionalPhraseFormState();
}

class _PrepositionalPhraseFormState extends State<PrepositionalPhraseForm> {
  bool isPrepositionFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        widget.settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: (widget.phrase.preposition?.en ?? Label.preposition)
                    .addSpace(),
                style: widget.phrase.preposition == null
                    ? Word.empty.style
                    : Word.preposition.style,
              ),
              TextSpan(
                text: (widget.phrase.object?.en ?? Label.object).addSpace(),
                style: widget.phrase.object == null
                    ? Word.empty.style
                    : Word.noun.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: (widget.phrase.preposition?.es ?? Label.prepositionEs)
                    .addSpace(),
                style: widget.phrase.preposition == null
                    ? Word.empty.style
                    : Word.preposition.style,
              ),
              TextSpan(
                text: (widget.phrase.object?.es ?? Label.objectEs).addSpace(),
                style: widget.phrase.object == null
                    ? Word.empty.style
                    : Word.noun.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        if (!isPrepositionFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: togglePrepositionField,
            style: Word.preposition.style,
            placeholder: Label.preposition,
            en: widget.phrase.preposition?.en,
            es: widget.phrase.preposition?.es,
            isRequired: true,
          ),
        if (isPrepositionFieldShown)
          DropdownTile(
            style: Word.verb.style,
            title: Label.preposition,
            textValue: widget.phrase.preposition?.en,
            textValueEs: widget.phrase.preposition?.es,
            required: true,
            fields: [
              ItemField<Preposition>(
                label: Label.preposition,
                options: vocabularyRepository.prepositions(),
                value: widget.phrase.preposition,
                setValue: setPreposition,
                toEnString: (Preposition e) => e.en,
                toEsString: (Preposition e) => e.es,
                onAccept: togglePrepositionField,
              ),
            ],
          ),
        ItemTile(
          style: Word.noun.style,
          placeholder: Label.object,
          en: widget.phrase.object?.en,
          es: widget.phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToObjectPage(context),
        ),
      ],
    );
  }

  void setPreposition(Preposition? val) =>
      widget.setPhrase(widget.phrase.copyWith(preposition: Nullable(val)));

  void setObject(AnyNoun? object) =>
      widget.setPhrase(widget.phrase.copyWith(object: Nullable(object)));

  void goToObjectPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                object: widget.phrase.object,
                isDitransitiveVerb: false,
                isIndirectObject: false,
                isNegative: widget.isNegative,
                isPlural: widget.isPlural)));
    if (response != null) {
      setObject(response is AnyNoun ? response : null);
    }
  }

  togglePrepositionField() =>
      setState(() => isPrepositionFieldShown = !isPrepositionFieldShown);
}
