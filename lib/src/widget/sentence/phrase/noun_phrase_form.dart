import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adjective/any_adjective.dart';
import '../../../model/sentence/determiner/determiner.dart';
import '../../../model/sentence/noun/noun.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adjectival_phrase_page.dart';

class NounPhraseForm extends StatelessWidget {
  final Widget settingsControl;
  final NounPhrase phrase;
  final void Function(NounPhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const NounPhraseForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
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
              if (phrase.allowQuantifier && phrase.quantifier != null)
                TextSpan(
                  text: phrase.quantifier == null
                      ? '<QuantifierOf> '
                      : '${phrase.quantifierOf} ',
                  style: phrase.quantifier == null
                      ? SentenceItem.placeholder.style
                      : SentenceItem.determiner.style,
                ),
              TextSpan(
                text: phrase.determiner == null
                    ? '<Determiner> '
                    : '${phrase.determiner} ',
                style: phrase.determiner == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.determiner.style,
              ),
              if (phrase.allowNumber && phrase.number != null)
                TextSpan(
                  text:
                      phrase.number == null ? '<Number> ' : '${phrase.number} ',
                  style: phrase.number == null
                      ? SentenceItem.placeholder.style
                      : SentenceItem.determiner.style,
                ),
              if (phrase.allowAdjective && phrase.adjective != null)
                TextSpan(
                  text: phrase.adjective == null
                      ? '<Adjective> '
                      : '${phrase.adjective} ',
                  style: phrase.adjective == null
                      ? SentenceItem.placeholder.style
                      : SentenceItem.adjective.style,
                ),
              TextSpan(
                text: phrase.noun == null ? '<Noun>' : phrase.noun.toString(),
                style: phrase.noun == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.noun.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.determiner.style,
          title: 'Quantifier',
          textValue: phrase.quantifierOf,
          textValueEs: phrase.quantifierOfEs,
          show: phrase.allowQuantifier,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Quantifier',
              value: phrase.quantifier,
              options: vocabularyRepository.quantifiers(phrase.noun),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (determiner) => setQuantifier(determiner),
              onChanged: (text) => setQuantifier(null),
            ),
          ],
        ),
        DropdownTile(
          style: SentenceItem.determiner.style,
          title: 'Determiner',
          textValue: phrase.determiner?.en,
          textValueEs: phrase.determiner?.es,
          required: true,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Determiner',
              value: phrase.determiner,
              options: determiners(vocabularyRepository),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (determiner) => setDeterminer(determiner),
              onChanged: (text) => setDeterminer(null),
            )
          ],
        ),
        DropdownTile(
          style: SentenceItem.determiner.style,
          title: 'Number',
          textValue: phrase.number?.en,
          textValueEs: phrase.number?.es,
          show: phrase.allowNumber,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Number',
              value: phrase.number,
              options: vocabularyRepository.numbers(phrase.noun, true),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (number) => setNumber(number),
              onChanged: (text) => setNumber(null),
            ),
          ],
        ),
        DropdownTile(
          style: SentenceItem.adjective.style,
          title: 'Adjective',
          textValue: phrase.adjective?.en,
          textValueEs: phrase.adjectiveEs,
          show: phrase.allowAdjective,
          fields: [
            SentenceItemField<Adjective>(
              label: 'Adjective',
              value: phrase.adjective,
              options: vocabularyRepository.adjectives(),
              filterValuesEn: [(Adjective e) => e.en],
              filterValuesEs: [
                (Adjective e) => e.singularEs,
                (Adjective e) => e.pluralEs,
              ],
              onSelected: (adjective) => setAdjective(adjective),
              onChanged: (text) => setAdjective(null),
            ),
          ],
        ),
        DropdownTile(
          style: SentenceItem.noun.style,
          title: 'Noun',
          textValue: phrase.noun?.en,
          textValueEs: phrase.noun?.es,
          required: true,
          fields: [
            SentenceItemField<Noun>(
              label: 'Noun',
              value: phrase.noun,
              options: vocabularyRepository.nouns(phrase.determiner),
              filterValuesEn: [(Noun e) => e.en],
              filterValuesEs: [(Noun e) => e.es],
              onSelected: (noun) => setNoun(noun),
              onChanged: (text) => setNoun(null),
            ),
          ],
        ),
        SentenceItemTile(
          style: SentenceItem.adjective.style,
          placeholder: '<PostModifierAdjective>',
          en: phrase.endAdjective?.toString(),
          es: phrase.endAdjective?.singularEs,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToAdjectivalPhrasePage(context),
        ),
      ],
    );
  }

  setQuantifier(quantifierOf) =>
      setPhrase(phrase.copyWith(quantifier: Nullable(quantifierOf)));

  setDeterminer(determiner) =>
      setPhrase(phrase.copyWith(determiner: Nullable(determiner)));

  setAdjective(adjective) =>
      setPhrase(phrase.copyWith(adjective: Nullable(adjective)));

  setNumber(number) => setPhrase(phrase.copyWith(number: Nullable(number)));

  setNoun(noun) => setPhrase(phrase.copyWith(noun: Nullable(noun)));

  setAdjectivalPhrase(AnyAdjective? adjective) =>
      setPhrase(phrase.copyWith(endAdjective: Nullable(adjective)));

  List<Determiner> determiners(VocabularyRepository vocabularyRepository) => [
        ...vocabularyRepository.articles(phrase.noun),
        ...vocabularyRepository.possessiveAdjectives(),
        ...vocabularyRepository.demonstrativeAdjectives(phrase.noun),
        ...vocabularyRepository.distributiveAdjectives(phrase.noun),
        ...vocabularyRepository.quantifiers(phrase.noun),
        ...vocabularyRepository.numbers(phrase.noun)
      ];

  goToAdjectivalPhrasePage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdjectivalPhrasePage(
                  adjective: phrase.endAdjective,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    setAdjectivalPhrase(response is AnyAdjective ? response : null);
  }
}
