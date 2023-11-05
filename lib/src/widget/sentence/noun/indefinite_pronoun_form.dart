import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/indefinite_pronoun.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class IndefinitePronounForm extends StatelessWidget {
  final Widget settingsControl;
  final bool isNegative;
  final IndefinitePronoun? pronoun;
  final void Function(IndefinitePronoun?) setPronoun;

  const IndefinitePronounForm({
    super.key,
    required this.settingsControl,
    required this.isNegative,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text(
            pronoun?.en ?? Label.indefinitePronoun,
            style: pronoun == null ? Word.empty.style : Word.noun.style,
          ),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.noun.style,
          title: Label.indefinitePronoun,
          textValue: pronoun?.en,
          required: true,
          fields: [
            SentenceItemField<IndefinitePronoun>(
              label: Label.indefinitePronoun,
              value: pronoun,
              options: vocabularyRepository.indefinitePronouns(isNegative),
              getEnWords: [(IndefinitePronoun e) => e.en],
              getEsWords: [(IndefinitePronoun e) => e.es],
              displayStringForOption: (pronoun) => pronoun.en,
              setValue: (pronoun) => setPronoun(pronoun),
            ),
          ],
        ),
      ],
    );
  }
}
