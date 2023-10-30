import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/preposition.dart';
import '../../../model/sentence/phrase/prepositional_phrase.dart';
import '../../../repository/common_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../noun/object_page.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class PrepositionalPhraseForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final PrepositionalPhrase phrase;
  final void Function(PrepositionalPhrase?) setPhrase;
  final bool isNegative;

  const PrepositionalPhraseForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final commonRepository = Provider.of<CommonRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.preposition == null
                    ? '<Preposition> '
                    : '${phrase.preposition!.en} ',
                style: phrase.preposition == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.noun.color),
              ),
              if (phrase.object != null)
                TextSpan(
                  text: '${phrase.object!.en} ',
                  style: TextStyle(color: SentenceItem.noun.color),
                ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: SentenceItem.verb.color,
          title: 'Preposition',
          textValue: phrase.preposition?.en,
          textValueEs: phrase.preposition?.es,
          required: true,
          fields: [
            SentenceItemField<Preposition>(
              label: 'Preposition',
              value: phrase.preposition,
              options: commonRepository.prepositions(),
              filterValuesEn: [(Preposition e) => e.en],
              filterValuesEs: [(Preposition e) => e.es],
              onSelected: (e) => setVerb(e),
              onChanged: (text) => setVerb(null),
            ),
          ],
        ),
        SentenceItemTile(
          color: SentenceItem.noun.color,
          label: "<VerbObject>",
          value: phrase.object?.en,
          valueEs: phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToObjectPage(context),
        ),
      ],
    );
  }

  void setVerb(Preposition? val) =>
      validateAndSet(phrase.copyWith(preposition: Nullable(val)));

  void setObject(AnyNoun? object) =>
      validateAndSet(phrase.copyWith(object: Nullable(object)));

  void validateAndSet(PrepositionalPhrase phrase) {
    setCanSave(phrase.preposition != null && phrase.object != null);
    setPhrase(phrase);
  }

  void navigateToObjectPage(BuildContext context) async {
    final object = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: phrase.object,
                  isDitransitiveVerb: false,
                  isIndirectObject: false,
                  isNegative: isNegative,
                )));
    if (object is AnyNoun) {
      setObject(object);
    } else if (object is bool && !object) {
      setObject(null);
    }
  }
}
