import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class AdverbForm extends StatelessWidget {
  final Widget settingsControl;
  final AdverbPosition position;
  final Adverb? adverb;
  final void Function(Adverb?) setAdverb;
  final Function(bool) setCanSave;

  const AdverbForm({
    super.key,
    required this.settingsControl,
    required this.adverb,
    required this.setAdverb,
    required this.position,
    required this.setCanSave,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    List<Adverb> adverbs = switch (position) {
      AdverbPosition.front => vocabularyRepository.frontAdverbs(),
      AdverbPosition.mid => vocabularyRepository.midAdverbs(),
      _ => vocabularyRepository.endAdverbs(),
    };

    String label = switch (position) {
      AdverbPosition.front => 'FrontAdverb',
      AdverbPosition.mid => 'MidAdverb',
      _ => 'EndAdverb',
    };

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: '${adverb ?? '<$label>'}',
                  style: (adverb == null)
                      ? SentenceItem.placeholder.style
                      : SentenceItem.adverb.style),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.adverb.style,
          title: label,
          textValue: adverb?.en,
          textValueEs: adverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: label,
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
    setCanSave(adverb != null);
    setAdverb(adverb);
  }
}
