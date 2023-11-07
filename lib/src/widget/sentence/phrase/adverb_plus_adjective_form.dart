import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/phrase/adverb_plus_adjective.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class AdverbPlusAdjectiveForm extends StatelessWidget {
  final Widget settingsControl;
  final AdverbPlusAdjective phrase;
  final void Function(AdverbPlusAdjective?) setPhrase;
  final bool isPlural;

  const AdverbPlusAdjectiveForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
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
                text: (phrase.adverb?.en ?? Label.adverb).addSpace(),
                style: phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              TextSpan(
                text: (phrase.adjective?.en ?? Label.adjective).addSpace(),
                style: phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: (phrase.adverb?.es ?? Label.adverbEs).addSpace(),
                style: phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              TextSpan(
                text:
                    (phrase.adjective?.toEs() ?? Label.adjectiveEs).addSpace(),
                style: phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.verb.style,
          title: Label.adverb,
          textValue: phrase.adverb?.en,
          textValueEs: phrase.adverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: Label.adverb,
              value: phrase.adverb,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.degreeAdverbs(),
              getEnWords: [(e) => e.en],
              getEsWords: [(e) => e.es],
              setValue: (e) => setAdverb(e),
            ),
          ],
        ),
        DropdownTile(
          style: Word.verb.style,
          title: Label.adjective,
          textValue: phrase.adjective?.en,
          textValueEs: isPlural
              ? phrase.adjective?.singularEs
              : phrase.adjective?.pluralEs,
          required: true,
          fields: [
            SentenceItemField<Adjective>(
              label: Label.adjective,
              value: phrase.adjective,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.adjectives(),
              getEnWords: [(e) => e.en],
              getEsWords: [(e) => isPlural ? e.pluralEs : e.singularEs],
              setValue: (e) => setAdjective(e),
            ),
          ],
        ),
      ],
    );
  }

  void setAdverb(Adverb? adverb) =>
      setPhrase(phrase.copyWith(adverb: Nullable(adverb)));

  void setAdjective(Adjective? adjective) =>
      setPhrase(phrase.copyWith(adjective: Nullable(adjective)));
}
