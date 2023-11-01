import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/noun/indefinite_pronoun.dart';
import '../../../model/sentence_item.dart';
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

    final pronouns = vocabularyRepository.indefinitePronouns(isNegative);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text(
            pronoun == null ? '<IndefinitePronoun>' : pronoun.toString(),
            style: pronoun == null
                ? SentenceItem.placeholder.style
                : SentenceItem.noun.style,
          ),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.noun.style,
          title: 'Indefinite Pronoun',
          textValue: pronoun?.en,
          fields: [
            SentenceItemField<IndefinitePronoun>(
              label: 'Indefinite Pronoun',
              value: pronoun,
              options: pronouns,
              filterValuesEn: [(IndefinitePronoun e) => e.en],
              filterValuesEs: [(IndefinitePronoun e) => e.es],
              displayStringForOption: (pronoun) => pronoun.en,
              onSelected: (pronoun) => validateAndSet(pronoun),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  void validateAndSet(IndefinitePronoun? pronoun) {
    setPronoun(pronoun);
  }
}
