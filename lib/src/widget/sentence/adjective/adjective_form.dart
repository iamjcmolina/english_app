import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';

class AdjectiveForm extends StatelessWidget {
  final Widget settingsControl;
  final Adjective? adjective;
  final void Function(Adjective?) setAdjective;

  const AdjectiveForm({
    super.key,
    required this.settingsControl,
    required this.adjective,
    required this.setAdjective,
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
                  text: adjective?.en ?? Label.adjective,
                  style: adjective == null
                      ? Word.empty.style
                      : Word.adjective.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: adjective?.es ?? Label.adjectiveEs,
                  style: adjective == null
                      ? Word.empty.style
                      : Word.adjective.style),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.adjective.style,
          title: Label.adjective,
          textValue: adjective?.en,
          required: true,
          fields: [
            SentenceItemField<Adjective>(
              label: Label.adjective,
              value: adjective,
              displayStringForOption: (e) => e.en,
              options: vocabularyRepository.adjectives(),
              getEnWords: [(Adjective e) => e.en],
              getEsWords: [
                (Adjective e) => e.singularEs,
                (Adjective e) => e.pluralEs,
              ],
              setValue: (adjective) => setAdjective(adjective),
            ),
          ],
        ),
      ],
    );
  }
}
