import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adjective/adjective_complement.dart';
import '../../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adjective_complement_page.dart';

class AdjectivePlusComplementForm extends StatelessWidget {
  final Widget settingsControl;
  final AdjectivePlusComplement phrase;
  final void Function(AdjectivePlusComplement?) setPhrase;
  final bool isPlural;
  final bool isNegative;

  const AdjectivePlusComplementForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isPlural,
    required this.isNegative,
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
                text: phrase.adjective == null
                    ? '<Adjective> '
                    : '${phrase.adjective!.en} ',
                style: phrase.adjective == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.adjective.style,
              ),
              TextSpan(
                text: phrase.complement == null
                    ? '<AdjectiveComplement> '
                    : '${phrase.complement!.en} ',
                style: phrase.complement == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.verb.style,
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
              options: vocabularyRepository.adjectives(),
              filterValuesEn: [(e) => e.en],
              filterValuesEs: [(e) => isPlural ? e.pluralEs : e.singularEs],
              onSelected: (e) => setAdjective(e),
              onChanged: (text) => setAdjective(null),
            ),
          ],
        ),
        SentenceItemTile(
          style: SentenceItem.adjective.style,
          placeholder: '<AdjectiveComplement>',
          en: phrase.complement?.en,
          es: phrase.complement?.es,
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
