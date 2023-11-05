import 'package:flutter/material.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/word.dart';
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
            pronoun?.en ?? Label.personalPronoun,
            style: pronoun == null ? Word.empty.style : Word.noun.style,
          ),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.noun.style,
          title: Label.personalPronoun,
          textValue: pronoun?.en,
          required: true,
          fields: [
            SentenceItemField<Pronoun>(
              label: Label.personalPronoun,
              value: pronoun,
              options: pronouns,
              getEnWords: [(Pronoun e) => e.en],
              getEsWords: [(Pronoun e) => e.es],
              displayStringForOption: (pronoun) => pronoun.en,
              setValue: (pronoun) => setPronoun(pronoun),
            ),
          ],
        ),
      ],
    );
  }
}
