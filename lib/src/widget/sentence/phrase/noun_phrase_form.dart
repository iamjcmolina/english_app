import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adjective/any_adjective.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/noun/noun.dart';
import '../../../model/sentence/phrase/determiner.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../repository/noun_repository.dart';
import '../../item_editor_layout.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';
import 'noun_phrase_post_modifier_page.dart';

class NounPhraseForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final NounPhrase? phrase;
  final void Function(NounPhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  NounPhrase get safePhrase => phrase ?? NounPhrase();

  const NounPhraseForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);

    Color quantifierOfColor = Colors.lightBlueAccent;
    Color determinerColor = Colors.cyan;
    Color numberColor = Colors.blueAccent;
    Color adjectiveColor = Colors.green;
    Color nounColor = Colors.orange;

    final nounRepository = Provider.of<NounRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              if (safePhrase.allowQuantifier && safePhrase.quantifier != null)
                TextSpan(
                  text: safePhrase.quantifier == null
                      ? '<QuantifierOf> '
                      : '${safePhrase.quantifierOf} ',
                  style: safePhrase.quantifier == null
                      ? unsetTextStyle
                      : TextStyle(color: quantifierOfColor),
                ),
              TextSpan(
                text: safePhrase.determiner == null
                    ? '<Determiner> '
                    : '${safePhrase.determiner} ',
                style: safePhrase.determiner == null
                    ? unsetTextStyle
                    : TextStyle(color: determinerColor),
              ),
              if (safePhrase.allowNumber && safePhrase.number != null)
                TextSpan(
                  text: safePhrase.number == null
                      ? '<Number> '
                      : '${safePhrase.number} ',
                  style: safePhrase.number == null
                      ? unsetTextStyle
                      : TextStyle(color: numberColor),
                ),
              if (safePhrase.allowAdjective && safePhrase.adjective != null)
                TextSpan(
                  text: safePhrase.adjective == null
                      ? '<Adjective> '
                      : '${safePhrase.adjective} ',
                  style: safePhrase.adjective == null
                      ? unsetTextStyle
                      : TextStyle(color: adjectiveColor),
                ),
              TextSpan(
                text: safePhrase.noun == null
                    ? '<Noun>'
                    : safePhrase.noun.toString(),
                style: safePhrase.noun == null
                    ? unsetTextStyle
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
          textValue: safePhrase.quantifierOf,
          textValueEs: safePhrase.quantifierOfEs,
          show: safePhrase.allowQuantifier,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Quantifier',
              value: safePhrase.quantifier,
              options: nounRepository.quantifiers(safePhrase.noun),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (determiner) => setQuantifier(determiner),
              onChanged: (text) => setQuantifier(null),
            ),
          ],
        ),
        DropdownTile(
          color: determinerColor,
          title: 'Determiner',
          textValue: safePhrase.determiner?.en,
          textValueEs: safePhrase.determiner?.es,
          required: true,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Determiner',
              value: safePhrase.determiner,
              options: determiners(nounRepository),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (determiner) => setDeterminer(determiner),
              onChanged: (text) => setDeterminer(null),
            )
          ],
        ),
        DropdownTile(
          color: numberColor,
          title: 'Number',
          textValue: safePhrase.number?.en,
          textValueEs: safePhrase.number?.es,
          show: safePhrase.allowNumber,
          fields: [
            SentenceItemField<Determiner>(
              label: 'Number',
              value: safePhrase.number,
              options: nounRepository.numbers(safePhrase.noun, true),
              filterValuesEn: [(Determiner e) => e.en],
              filterValuesEs: [(Determiner e) => e.es],
              onSelected: (number) => setNumber(number),
              onChanged: (text) => setNumber(null),
            ),
          ],
        ),
        DropdownTile(
          color: adjectiveColor,
          title: 'Adjective',
          textValue: safePhrase.adjective?.en,
          textValueEs: safePhrase.adjectiveEs,
          show: safePhrase.allowAdjective,
          fields: [
            SentenceItemField<Adjective>(
              label: 'Adjective',
              value: safePhrase.adjective,
              options: nounRepository.adjectives(),
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
          color: nounColor,
          title: 'Noun',
          textValue: safePhrase.noun?.en,
          textValueEs: safePhrase.noun?.es,
          required: true,
          fields: [
            SentenceItemField<Noun>(
              label: 'Noun',
              value: safePhrase.noun,
              options: nounRepository.nouns(safePhrase.determiner),
              filterValuesEn: [(Noun e) => e.en],
              filterValuesEs: [(Noun e) => e.es],
              onSelected: (noun) => setNoun(noun),
              onChanged: (text) => setNoun(null),
            ),
          ],
        ),
        SentenceItemTile(
          color: SentenceItem.adjective.color,
          label: '<PostModifierAdjective>',
          value: safePhrase.postModifier?.toString(),
          valueEs: safePhrase.postModifier?.singularEs,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToPostModifierPage(context),
        ),
      ],
    );
  }

  setQuantifier(quantifierOf) =>
      validateAndSet(safePhrase.copyWith(quantifier: Nullable(quantifierOf)));

  setDeterminer(determiner) =>
      validateAndSet(safePhrase.copyWith(determiner: Nullable(determiner)));

  setAdjective(adjective) =>
      validateAndSet(safePhrase.copyWith(adjective: Nullable(adjective)));

  setNumber(number) =>
      validateAndSet(safePhrase.copyWith(number: Nullable(number)));

  setNoun(noun) => validateAndSet(safePhrase.copyWith(noun: Nullable(noun)));

  setPostModifier(AnyAdjective? modifier) =>
      validateAndSet(safePhrase.copyWith(postModifier: Nullable(modifier)));

  validateAndSet(NounPhrase phrase) {
    setCanSave(phrase.determiner != null && phrase.noun != null);
    setPhrase(phrase);
  }

  List<Determiner> determiners(NounRepository nounRepository) => [
        ...nounRepository.articles(safePhrase.noun),
        ...nounRepository.possessiveAdjectives(),
        ...nounRepository.demonstrativeAdjectives(safePhrase.noun),
        ...nounRepository.distributiveAdjectives(safePhrase.noun),
        ...nounRepository.quantifiers(safePhrase.noun),
        ...nounRepository.numbers(safePhrase.noun)
      ];

  navigateToPostModifierPage(BuildContext context) async {
    final modifier = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NounPhrasePostModifierPage(
                  modifier: safePhrase.postModifier,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (modifier is AnyAdjective) {
      setPostModifier(modifier);
    } else if (modifier is bool && !modifier) {
      setPostModifier(null);
    }
  }
}
