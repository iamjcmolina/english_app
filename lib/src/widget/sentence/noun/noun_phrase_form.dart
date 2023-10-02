import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/noun/noun.dart';
import '../../../model/sentence/phrase/determiner.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../service/vocabulary_service.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';

class NounPhraseForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final NounPhrase? nounPhrase;
  final void Function(NounPhrase?) setNounPhrase;

  NounPhrase get safePhrase => nounPhrase ?? NounPhrase();

  const NounPhraseForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.nounPhrase,
    required this.setNounPhrase,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);

    Color quantifierOfColor = Colors.lightBlueAccent;
    Color determinerColor = Colors.cyan;
    Color numberColor = Colors.blueAccent;
    Color adjectiveColor = Colors.green;
    Color nounColor = Colors.orange;

    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Determiner> articles = vocabularyService.articles(safePhrase.noun);
    List<Determiner> possessives = vocabularyService.possessives();
    List<Determiner> demonstratives = vocabularyService.demonstratives(safePhrase.noun);
    List<Determiner> distributives = vocabularyService.distributives(safePhrase.noun);
    List<Determiner> quantifiers = vocabularyService.quantifiers(safePhrase.noun);
    List<Determiner> numbers = vocabularyService.numbers(safePhrase.noun);
    List<Determiner> allNumbers = vocabularyService.numbers(safePhrase.noun, true);
    List<String> adjectives = vocabularyService.adjectives();
    List<Noun> nouns = vocabularyService.nouns(safePhrase.determiner);
    List<Determiner> determiners = [...articles, ...possessives
      ,...demonstratives,...distributives,...quantifiers, ...numbers];

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              if (safePhrase.allowQuantifier && safePhrase.quantifier != null) TextSpan(
                text: safePhrase.quantifier == null? '<QuantifierOf> '
                    : '${safePhrase.quantifierText} ',
                style: safePhrase.quantifier == null? unsetTextStyle
                    : TextStyle(color: quantifierOfColor),
              ),
              TextSpan(
                text: safePhrase.determiner == null? '<Determiner> '
                    : '${safePhrase.determiner} ',
                style: safePhrase.determiner == null? unsetTextStyle
                    : TextStyle(color: determinerColor),
              ),
              if (safePhrase.allowNumber && safePhrase.number != null) TextSpan(
                text: safePhrase.number == null? '<Number> '
                    : '${safePhrase.number} ',
                style: safePhrase.number == null? unsetTextStyle
                    : TextStyle(color: numberColor),
              ),
              if (safePhrase.allowAdjective && safePhrase.adjective != null) TextSpan(
                text: safePhrase.adjective == null? '<Adjective> '
                    : '${safePhrase.adjective} ',
                style: safePhrase.adjective == null? unsetTextStyle
                    : TextStyle(color: adjectiveColor),
              ),
              TextSpan(
                text: safePhrase.noun == null? '<Noun>' : safePhrase.noun.toString(),
                style: safePhrase.noun == null? unsetTextStyle
                    : TextStyle(color: nounColor),
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
            color: quantifierOfColor,
            title: 'Quantifier',
            textValue: safePhrase.quantifierText,
            show: safePhrase.allowQuantifier,
            fields: [
              SentenceItemField<Determiner>(
                label: 'Quantifier',
                value: safePhrase.quantifier,
                options: quantifiers,
                onSelected: (determiner) => setQuantifier(determiner),
                onChanged: (text) => setQuantifier(null),
              ),
            ],
        ),
        DropdownTile(
          color: determinerColor,
          title: 'Determiner',
          textValue: safePhrase.determiner?.value,
          required: true,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Determiner',
              value: safePhrase.determiner,
              options: determiners,
              onSelected: (determiner) => setDeterminer(determiner),
              onChanged: (text) => setDeterminer(null),
            )
          ],
        ),
        DropdownTile(
          color: numberColor,
          title: 'Number',
          textValue: safePhrase.number?.value,
          show: safePhrase.allowNumber,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Number',
              value: safePhrase.number,
              options: allNumbers,
              onSelected: (number) => setNumber(number),
              onChanged: (text) => setNumber(null),
            ),
          ],
        ),
        DropdownTile(
          color: adjectiveColor,
          title: 'Adjective',
          textValue: safePhrase.adjective,
          show: safePhrase.allowAdjective,
          fields: [
            SentenceItemField<String>(
              label: 'Adjective',
              value: safePhrase.adjective,
              options: adjectives,
              onSelected: (adjective) => setAdjective(adjective),
              onChanged: (text) => setAdjective(null),
            ),
          ],
        ),
        DropdownTile(
          color: nounColor,
          title: 'Noun',
          textValue: safePhrase.noun?.value,
          required: true,
          fields: [
            SentenceItemField<Noun>(
              label: 'Noun',
              value: safePhrase.noun,
              options: nouns,
              onSelected: (noun) => setNoun(noun),
              onChanged: (text) => setNoun(null),
            ),
          ],
        ),
      ],
    );
  }

  setQuantifier(quantifierOf) =>
      validateAndSet(safePhrase.copyWith(quantifierOf: Nullable(quantifierOf)));

  setDeterminer(determiner) =>
      validateAndSet(safePhrase.copyWith(determiner: Nullable(determiner)));

  setAdjective(adjective) =>
      validateAndSet(safePhrase.copyWith(adjective: Nullable(adjective)));

  setNumber(number) =>
      validateAndSet(safePhrase.copyWith(number: Nullable(number)));

  setNoun(noun) =>
      validateAndSet(safePhrase.copyWith(noun: Nullable(noun)));

  validateAndSet(NounPhrase phrase) {
    setCanSave(phrase.determiner != null && phrase.noun != null);
    setNounPhrase(phrase);
  }
}
