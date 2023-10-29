import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/noun/indefinite_pronoun.dart';
import '../../../repository/noun_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class IndefinitePronounForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final bool isNegative;
  final IndefinitePronoun? pronoun;
  final void Function(IndefinitePronoun?) setPronoun;

  const IndefinitePronounForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.isNegative,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    const Color pronounColor = Colors.deepPurpleAccent;

    final nounRepository = Provider.of<NounRepository>(context);

    final pronouns = nounRepository.indefinitePronouns(isNegative);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text(
            pronoun == null ? '<IndefinitePronoun>' : pronoun.toString(),
            style: pronoun == null
                ? unsetTextStyle
                : const TextStyle(color: pronounColor),
          ),
        ),
      ],
      body: [
        DropdownTile(
          color: pronounColor,
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
    setCanSave(pronoun != null);
    setPronoun(pronoun);
  }
}
