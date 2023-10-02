import 'package:flutter/material.dart';

import '../../../model/sentence/noun/pronoun.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class PronounForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final List<Pronoun> pronouns;
  final Pronoun? pronoun;
  final void Function(Pronoun?) setPronoun;

  const PronounForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.pronouns,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    const Color pronounColor = Colors.deepPurpleAccent;

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text(
            pronoun == null? '<Pronoun>' : pronoun.toString(),
            style: pronoun == null? unsetTextStyle
                : const TextStyle(color: pronounColor),
          ),
        ),
      ],
      body: [
        DropdownTile(
          color: pronounColor,
          title: 'Pronoun',
          textValue: pronoun?.value,
          fields: [
            SentenceItemField<Pronoun>(
              label: 'Pronoun',
              value: pronoun,
              options: pronouns,
              displayStringForOption: (pronoun) => pronoun.value,
              onSelected: (pronoun) => validateAndSet(pronoun),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  validateAndSet(Pronoun? pronoun) {
    setCanSave(pronoun != null);
    setPronoun(pronoun);
  }
}
