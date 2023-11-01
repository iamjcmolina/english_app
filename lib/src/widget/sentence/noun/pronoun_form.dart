import 'package:flutter/material.dart';

import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/sentence_item.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class PronounForm extends StatelessWidget {
  final Widget settingsControl;
  final List<Pronoun> pronouns;
  final Pronoun? pronoun;
  final void Function(Pronoun?) setPronoun;

  const PronounForm({
    super.key,
    required this.settingsControl,
    required this.pronouns,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  Widget build(BuildContext context) {
    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text(
            pronoun == null ? '<Pronoun>' : pronoun.toString(),
            style: pronoun == null
                ? SentenceItem.placeholder.style
                : SentenceItem.noun.style,
          ),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.noun.style,
          title: 'Pronoun',
          textValue: pronoun?.en,
          fields: [
            SentenceItemField<Pronoun>(
              label: 'Pronoun',
              value: pronoun,
              options: pronouns,
              filterValuesEn: [(Pronoun e) => e.en],
              filterValuesEs: [(Pronoun e) => e.es],
              displayStringForOption: (pronoun) => pronoun.en,
              onSelected: (pronoun) => validateAndSet(pronoun),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  validateAndSet(Pronoun? pronoun) {
    setPronoun(pronoun);
  }
}
