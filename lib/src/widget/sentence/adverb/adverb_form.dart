import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../service/vocabulary_service.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class AdverbForm extends StatelessWidget {
  final Widget settingsControl;
  final AdverbPosition position;
  final Adverb? adverb;
  final void Function(Adverb?) setAdverb;
  final Function(bool) setCanSave;

  const AdverbForm({
    super.key,
    required this.settingsControl,
    required this.adverb,
    required this.setAdverb,
    required this.position,
    required this.setCanSave,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Adverb> adverbs = switch(position) {
      AdverbPosition.front => vocabularyService.frontAdverbs(),
      AdverbPosition.mid => vocabularyService.midAdverbs(),
      _ => vocabularyService.endAdverbs(),
    };

    String label = switch(position) {
      AdverbPosition.front => 'FrontAdverb',
      AdverbPosition.mid => 'MidAdverb',
      _ => 'EndAdverb',
    };

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: '${adverb ?? '<$label>'}',
                  style: (adverb == null)? unsetTextStyle
                      : TextStyle(color: IndependentClausePartColor.adverb.color)
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: IndependentClausePartColor.adverb.color,
          title: label,
          textValue: adverb?.value,
          required: true,
          fields: [
            SentenceItemField<Adverb>(
              label: label,
              value: adverb,
              options: adverbs,
              onSelected: (adverb) => validateAndSet(adverb),
              onChanged: (text) => validateAndSet(null),
            ),
          ],
        ),
      ],
    );
  }

  validateAndSet(Adverb? adverb) {
    setCanSave(adverb != null);
    setAdverb(adverb);
  }
}