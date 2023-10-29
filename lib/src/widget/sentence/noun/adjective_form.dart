import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adjective/adjective.dart';
import '../../../repository/noun_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class AdjectiveForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final Adjective? adjective;
  final void Function(Adjective?) setAdjective;

  const AdjectiveForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.adjective,
    required this.setAdjective,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);

    Color adjectiveColor = Colors.green;

    final nounRepository = Provider.of<NounRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: adjective == null ? '<Adjective> ' : '$adjective ',
                style: adjective == null
                    ? unsetTextStyle
                    : TextStyle(color: adjectiveColor),
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: adjectiveColor,
          title: 'Adjective',
          textValue: adjective?.en,
          fields: [
            SentenceItemField<Adjective>(
              label: 'Adjective',
              value: adjective,
              options: nounRepository.adjectives(),
              filterValues: [
                (Adjective e) => e.en,
                (Adjective e) => e.singularEs,
                (Adjective e) => e.pluralEs,
              ],
              onSelected: (adjective) => validateAndSet(adjective),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  validateAndSet(Adjective? adjective) {
    setCanSave(adjective != null);
    setAdjective(adjective);
  }
}
