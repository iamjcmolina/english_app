import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adjective/any_adjective.dart';
import '../../../model/sentence/determiner/determiner.dart';
import '../../../model/sentence/noun/noun.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../model/word.dart';
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
              TextSpan(
                text: phrase.allowQuantifier
                    ? phrase.quantifierOf?.addSpace()
                    : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: (phrase.determiner?.en ?? Label.determiner).addSpace(),
                style: phrase.determiner == null
                    ? Word.empty.style
                    : Word.determiner.style,
              ),
              TextSpan(
                text: phrase.allowNumber ? phrase.number?.en.addSpace() : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: phrase.allowAdjective
                    ? phrase.adjective?.en.addSpace()
                    : null,
                style: Word.adjective.style,
              ),
              TextSpan(
                text: (phrase.noun?.en ?? Label.noun).addSpace(),
                style: phrase.noun == null ? Word.empty.style : Word.noun.style,
              ),
              TextSpan(
                text: phrase.adjectivalPhrase?.en,
                style: Word.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.determiner.style,
          title: Label.quantifier,
          textValue: phrase.quantifierOf,
          textValueEs: phrase.quantifierOfEs,
          show: phrase.allowQuantifier,
          fields: [
            SentenceItemField<Determiner>(
              label: Label.quantifier,
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
          style: Word.determiner.style,
          title: Label.determiner,
          textValue: phrase.determiner?.en,
          textValueEs: phrase.determiner?.es,
          required: true,
          fields: [
            SentenceItemField<Determiner>(
              label: Label.determiner,
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
          style: Word.determiner.style,
          title: Label.number,
          textValue: phrase.number?.en,
          textValueEs: phrase.number?.es,
          show: phrase.allowNumber,
          fields: [
            SentenceItemField<Determiner>(
              label: Label.number,
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
          style: Word.adjective.style,
          title: Label.adjective,
          textValue: phrase.adjective?.en,
          textValueEs: phrase.adjectiveEs,
          show: phrase.allowAdjective,
          fields: [
            SentenceItemField<Adjective>(
              label: Label.adjective,
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
          style: Word.noun.style,
          title: Label.noun,
          textValue: phrase.noun?.en,
          textValueEs: phrase.noun?.es,
          required: true,
          fields: [
            SentenceItemField<Noun>(
              label: Label.noun,
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
          style: Word.adjective.style,
          placeholder: Label.adjectivalPhrase,
          en: phrase.adjectivalPhrase?.toString(),
          es: phrase.adjectivalPhrase?.singularEs,
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
      setPhrase(phrase.copyWith(adjectivalPhrase: Nullable(adjective)));

  List<Determiner> determiners(VocabularyRepository vocabularyRepository) => [
        ...vocabularyRepository.articles(phrase.noun),
        ...vocabularyRepository.possessiveAdjectives(),
        ...vocabularyRepository.demonstrativeAdjectives(phrase.noun),
        ...vocabularyRepository.distributiveAdjectives(phrase.noun),
        ...vocabularyRepository.quantifiers(phrase.noun),
        ...vocabularyRepository.numbers(phrase.noun)
      ];

  void goToAdjectivalPhrasePage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdjectivalPhrasePage(
                  adjective: phrase.adjectivalPhrase,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (response != null) {
      setAdjectivalPhrase(response is AnyAdjective ? response : null);
    }
  }
}
