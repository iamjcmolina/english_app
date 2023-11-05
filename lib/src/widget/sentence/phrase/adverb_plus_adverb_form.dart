import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/phrase/adverb_plus_adverb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class AdverbPlusAdverbForm extends StatelessWidget {
  final Widget settingsControl;
  final AdverbPlusAdverb phrase;
  final void Function(AdverbPlusAdverb?) setPhrase;

  const AdverbPlusAdverbForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
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
                text: (phrase.intensifierAdverb?.en ?? Label.adverb).addSpace(),
                style: phrase.intensifierAdverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              TextSpan(
                text: (phrase.adverb?.en ?? Label.adverb).addSpace(),
                style: phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.verb.style,
          title: Label.adverb,
          textValue: phrase.intensifierAdverb?.en,
          textValueEs: phrase.intensifierAdverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: Label.adverb,
              value: phrase.intensifierAdverb,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.endAdverbs(),
              getEnWords: [(e) => e.en],
              getEsWords: [(e) => e.es],
              setValue: (e) => setIntensifierOrMitigator(e),
            ),
          ],
        ),
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
              options: vocabularyRepository.endAdverbs(),
              getEnWords: [(e) => e.en],
              getEsWords: [(e) => e.es],
              setValue: (e) => setAdverb(e),
            ),
          ],
        ),
      ],
    );
  }

  void setIntensifierOrMitigator(Adverb? adverb) =>
      setPhrase(phrase.copyWith(intensifierAdverb: Nullable(adverb)));

  void setAdverb(Adverb? adverb) =>
      setPhrase(phrase.copyWith(adverb: Nullable(adverb)));
}
