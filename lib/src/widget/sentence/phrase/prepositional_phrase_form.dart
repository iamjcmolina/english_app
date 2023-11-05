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
                text: (phrase.preposition?.en ?? Label.preposition).addSpace(),
                style: phrase.preposition == null
                    ? Word.empty.style
                    : Word.preposition.style,
              ),
              TextSpan(
                text: (phrase.object?.en ?? Label.object).addSpace(),
                style:
                    phrase.object == null ? Word.empty.style : Word.noun.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.verb.style,
          title: Label.preposition,
          textValue: phrase.preposition?.en,
          textValueEs: phrase.preposition?.es,
          required: true,
          fields: [
            SentenceItemField<Preposition>(
              label: Label.preposition,
              value: phrase.preposition,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.prepositions(),
              getEnWords: [(Preposition e) => e.en],
              getEsWords: [(Preposition e) => e.es],
              setValue: (e) => setVerb(e),
            ),
          ],
        ),
        SentenceItemTile(
          style: Word.noun.style,
          placeholder: Label.object,
          en: phrase.object?.en,
          es: phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToObjectPage(context),
        ),
      ],
    );
  }

  void setVerb(Preposition? val) =>
      setPhrase(phrase.copyWith(preposition: Nullable(val)));

  void setObject(AnyNoun? object) =>
      setPhrase(phrase.copyWith(object: Nullable(object)));

  void goToObjectPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                object: phrase.object,
                isDitransitiveVerb: false,
                isIndirectObject: false,
                isNegative: isNegative,
                isPlural: isPlural)));
    if (response != null) {
      setObject(response is AnyNoun ? response : null);
    }
  }
}
