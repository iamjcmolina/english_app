import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/phrase/adverb_plus_adverb.dart';
import '../../../repository/adverb_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class AdverbPlusAdverbForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final AdverbPlusAdverb phrase;
  final void Function(AdverbPlusAdverb?) setPhrase;

  const AdverbPlusAdverbForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final adverbRepository = Provider.of<AdverbRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.modifier == null
                    ? '<IntensifierOrMitigatorAdverb> '
                    : '${phrase.modifier!.en} ',
                style: phrase.modifier == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adverb.color),
              ),
              TextSpan(
                text: phrase.regularAdverb == null
                    ? '<Adverb> '
                    : '${phrase.regularAdverb!.en} ',
                style: phrase.regularAdverb == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adverb.color),
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: SentenceItem.verb.color,
          title: '<IntensifierOrMitigatorAdverb>',
          textValue: phrase.modifier?.en,
          textValueEs: phrase.modifier?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: '<IntensifierOrMitigatorAdverb>',
              value: phrase.modifier,
              displayStringForOption: (e) => e.en,
              options: adverbRepository.endAdverbs(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => e.es],
              onSelected: (e) => setModifier(e),
              onChanged: (text) => setModifier(null),
            ),
          ],
        ),
        DropdownTile(
          color: SentenceItem.verb.color,
          title: '<Adverb>',
          textValue: phrase.regularAdverb?.en,
          textValueEs: phrase.regularAdverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: '<Adverb>',
              value: phrase.regularAdverb,
              displayStringForOption: (e) => e.en,
              options: adverbRepository.endAdverbs(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => e.es],
              onSelected: (e) => setModifier(e),
              onChanged: (text) => setModifier(null),
            ),
          ],
        ),
      ],
    );
  }

  void setModifier(Adverb? adverb) =>
      validateAndSet(phrase.copyWith(modifier: Nullable(adverb)));

  void setRegularAdverb(Adverb? adverb) =>
      validateAndSet(phrase.copyWith(regularAdverb: Nullable(adverb)));

  void validateAndSet(AdverbPlusAdverb phrase) {
    setCanSave(phrase.modifier != null && phrase.regularAdverb != null);
    setPhrase(phrase);
  }
}
