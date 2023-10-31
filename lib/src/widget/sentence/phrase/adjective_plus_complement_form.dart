import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/phrase/adjective_complement.dart';
import '../../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../../repository/noun_repository.dart';
import '../../item_editor_layout.dart';
import '../adjective/adjective_complement_page.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class AdjectivePlusComplementForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final AdjectivePlusComplement phrase;
  final void Function(AdjectivePlusComplement?) setPhrase;
  final bool isPlural;
  final bool isNegative;

  const AdjectivePlusComplementForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isPlural,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final nounRepository = Provider.of<NounRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.adjective == null
                    ? '<Adjective> '
                    : '${phrase.adjective!.en} ',
                style: phrase.adjective == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adjective.color),
              ),
              TextSpan(
                text: phrase.complement == null
                    ? '<AdjectiveComplement> '
                    : '${phrase.complement!.en} ',
                style: phrase.complement == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adjective.color),
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: SentenceItem.verb.color,
          title: '<Adjective>',
          textValue: phrase.adjective?.en,
          textValueEs: isPlural
              ? phrase.adjective?.singularEs
              : phrase.adjective?.pluralEs,
          required: true,
          fields: [
            SentenceItemField<Adjective>(
              label: '<Adjective>',
              value: phrase.adjective,
              displayStringForOption: (e) => e.en,
              options: nounRepository.adjectives(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => isPlural ? e.pluralEs : e.singularEs],
              onSelected: (e) => setAdjective(e),
              onChanged: (text) => setAdjective(null),
            ),
          ],
        ),
        SentenceItemTile(
          color: SentenceItem.adjective.color,
          label: '<AdjectiveComplement>',
          value: phrase.complement?.en,
          valueEs: phrase.complement?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToComplementPage(context),
        ),
      ],
    );
  }

  void setAdjective(Adjective? adjective) =>
      validateAndSet(phrase.copyWith(adjective: Nullable(adjective)));

  void setComplement(AdjectiveComplement? complement) =>
      validateAndSet(phrase.copyWith(complement: Nullable(complement)));

  void validateAndSet(AdjectivePlusComplement phrase) {
    setCanSave(phrase.adjective != null && phrase.complement != null);
    setPhrase(phrase);
  }

  navigateToComplementPage(BuildContext context) async {
    final complement = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdjectiveComplementPage(
                  complement: phrase.complement,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (complement is AdjectiveComplement) {
      setComplement(complement);
    } else if (complement is bool && !complement) {
      setComplement(null);
    }
  }
}
