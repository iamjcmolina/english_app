import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/phrase/adverb_plus_adjective.dart';
import '../../../repository/adverb_repository.dart';
import '../../../repository/noun_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class AdverbPlusAdjectiveForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final AdverbPlusAdjective phrase;
  final void Function(AdverbPlusAdjective?) setPhrase;
  final bool isPlural;

  const AdverbPlusAdjectiveForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isPlural,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final nounRepository = Provider.of<NounRepository>(context);
    final adverbRepository = Provider.of<AdverbRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.adverb == null
                    ? '<Adverb> '
                    : '${phrase.adverb!.en} ',
                style: phrase.adverb == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adverb.color),
              ),
              TextSpan(
                text: phrase.adjective == null
                    ? '<Adjective> '
                    : '${phrase.adjective!.en} ',
                style: phrase.adjective == null
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
          title: '<Adverb>',
          textValue: phrase.adverb?.en,
          textValueEs: phrase.adverb?.es,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: '<Adverb>',
              value: phrase.adverb,
              displayStringForOption: (e) => e.en,
              options: adverbRepository.endAdverbs(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => e.es],
              onSelected: (e) => setAdverb(e),
              onChanged: (text) => setAdverb(null),
            ),
          ],
        ),
        DropdownTile(
          color: SentenceItem.verb.color,
          title: '<Adjective>',
          textValue: phrase.adjective?.en,
          textValueEs: isPlural
              ? phrase.adjective?.singularEs
              : phrase.adjective?.pluralEs,
          required: true,
          fields: [
            SentenceItemField<Adjective>(
              label: '<Adjective>',
              value: phrase.adjective,
              displayStringForOption: (e) => e.en,
              options: nounRepository.adjectives(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => isPlural ? e.pluralEs : e.singularEs],
              onSelected: (e) => setAdjective(e),
              onChanged: (text) => setAdjective(null),
            ),
          ],
        ),
      ],
    );
  }

  void setAdverb(Adverb? adverb) =>
      validateAndSet(phrase.copyWith(adverb: Nullable(adverb)));

  void setAdjective(Adjective? adjective) =>
      validateAndSet(phrase.copyWith(adjective: Nullable(adjective)));

  void validateAndSet(AdverbPlusAdjective phrase) {
    setCanSave(phrase.adverb != null && phrase.adjective != null);
    setPhrase(phrase);
  }
}
