import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class AdverbForm extends StatelessWidget {
  final Widget settingsControl;
  final AdverbPosition position;
  final Adverb? adverb;
  final void Function(Adverb?) setAdverb;

  const AdverbForm({
    super.key,
    required this.settingsControl,
    required this.adverb,
    required this.setAdverb,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    List<Adverb> adverbs = switch (position) {
      AdverbPosition.front => vocabularyRepository.frontAdverbs(),
      AdverbPosition.mid => vocabularyRepository.midAdverbs(),
      _ => vocabularyRepository.endAdverbs(),
    };

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: adverb?.en ?? Label.adverb,
                  style: adverb == null ? Word.empty.style : Word.adverb.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: adverb?.es ?? Label.adverbEs,
                  style: adverb == null ? Word.empty.style : Word.adverb.style),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.adverb.style,
          title: Label.adverb,
          textValue: adverb?.en,
          textValueEs: adverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: Label.adverb,
              value: adverb,
              options: adverbs,
              displayStringForOption: (e) => e.en,
              getEnWords: [(Adverb e) => e.en],
              getEsWords: [(Adverb e) => e.es],
              setValue: (e) => setAdverb(e),
            ),
          ],
        ),
      ],
    );
  }
}
