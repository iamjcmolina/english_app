import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
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
                  text: adverb?.en ?? AnyAdverb.adverbPlaceholder,
                  style: adverb == null ? Word.empty.style : Word.adverb.style),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.adverb.style,
          title: AnyAdverb.adverbPlaceholder,
          textValue: adverb?.en,
          textValueEs: adverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: AnyAdverb.adverbPlaceholder,
              value: adverb,
              options: adverbs,
              filterValuesEn: [(Adverb e) => e.en],
              filterValuesEs: [(Adverb e) => e.es],
              onSelected: (e) => validateAndSet(e),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  void validateAndSet(Adverb? adverb) {
    setAdverb(adverb);
  }
}
