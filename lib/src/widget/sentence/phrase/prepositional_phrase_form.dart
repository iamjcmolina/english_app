import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/prepositional_phrase.dart';
import '../../../model/sentence/preposition/preposition.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/object_page.dart';

class PrepositionalPhraseForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.preposition == null
                    ? '<Preposition> '
                    : '${phrase.preposition!.en} ',
                style: phrase.preposition == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.preposition.style,
              ),
              TextSpan(
                text: phrase.object == null ? '' : '${phrase.object!.en} ',
                style: SentenceItem.noun.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.verb.style,
          title: 'Preposition',
          textValue: phrase.preposition?.en,
          textValueEs: phrase.preposition?.es,
          required: true,
          fields: [
            SentenceItemField<Preposition>(
              label: 'Preposition',
              value: phrase.preposition,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.prepositions(),
              filterValuesEn: [(Preposition e) => e.en],
              filterValuesEs: [(Preposition e) => e.es],
              onSelected: (e) => setVerb(e),
              onChanged: (text) => setVerb(null),
            ),
          ],
        ),
        SentenceItemTile(
          style: SentenceItem.noun.style,
          placeholder: "<VerbObject>",
          en: phrase.object?.en,
          es: phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToObjectPage(context),
        ),
      ],
    );
  }

  void setVerb(Preposition? val) =>
      validateAndSet(phrase.copyWith(preposition: Nullable(val)));

  void setObject(AnyNoun? object) =>
      validateAndSet(phrase.copyWith(object: Nullable(object)));

  void validateAndSet(PrepositionalPhrase phrase) {
    setPhrase(phrase);
  }

  void navigateToObjectPage(BuildContext context) async {
    final object = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: phrase.object,
                  isDitransitiveVerb: false,
                  isIndirectObject: false,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (object is AnyNoun) {
      setObject(object);
    } else if (object is bool && !object) {
      setObject(null);
    }
  }
}
