import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/noun/noun.dart';
import '../../../model/sentence/phrase/determiner.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../service/vocabulary_service.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class NounPhraseForm extends StatefulWidget {
  final void Function(NounPhrase?) setNounPhrase;
  final NounPhrase? nounPhrase;

  const NounPhraseForm({
    super.key,
    required this.setNounPhrase,
    this.nounPhrase,
  });

  @override
  State<NounPhraseForm> createState() => _NounPhraseFormState();
}

class _NounPhraseFormState extends State<NounPhraseForm> {
  bool settingQuantifierOf = false;
  bool settingDeterminer = false;
  bool settingNumber = false;
  bool settingAdjective = false;
  bool settingNoun = false;

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);

    Color quantifierOfColor = Colors.lightBlueAccent;
    Color determinerColor = Colors.cyan;
    Color numberColor = Colors.blueAccent;
    Color adjectiveColor = Colors.green;
    Color nounColor = Colors.orange;

    final vocabularyService = Provider.of<VocabularyService>(context);

    List<Determiner> articles = vocabularyService.articles(nounPhrase.noun);
    List<Determiner> possessives = vocabularyService.possessives();
    List<Determiner> demonstratives = vocabularyService.demonstratives(nounPhrase.noun);
    List<Determiner> distributives = vocabularyService.distributives(nounPhrase.noun);
    List<Determiner> quantifiers = vocabularyService.quantifiers(nounPhrase.noun);
    List<Determiner> numbers = vocabularyService.numbers(nounPhrase.noun);
    List<Determiner> allNumbers = vocabularyService.numbers(nounPhrase.noun, true);
    List<String> adjectives = vocabularyService.adjectives();
    List<Noun> nouns = vocabularyService.nouns(nounPhrase.determiner);
    List<Determiner> determiners = [...articles, ...possessives
      ,...demonstratives,...distributives,...quantifiers, ...numbers];

    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: Text.rich(TextSpan(
              children: [
                if (nounPhrase.allowQuantifierOf && nounPhrase.quantifierOf != null) TextSpan(
                  text: nounPhrase.quantifierOf == null? '<QuantifierOf> '
                      : '${nounPhrase.quantifierOfText} ',
                  style: nounPhrase.quantifierOf == null? unsetTextStyle
                      : TextStyle(color: quantifierOfColor),
                ),
                TextSpan(
                  text: nounPhrase.determiner == null? '<Determiner> '
                      : '${nounPhrase.determiner} ',
                  style: nounPhrase.determiner == null? unsetTextStyle
                      : TextStyle(color: determinerColor),
                ),
                if (nounPhrase.allowNumber && nounPhrase.number != null) TextSpan(
                  text: nounPhrase.number == null? '<Number> '
                      : '${nounPhrase.number} ',
                  style: nounPhrase.number == null? unsetTextStyle
                      : TextStyle(color: numberColor),
                ),
                if (nounPhrase.allowAdjective && nounPhrase.adjective != null) TextSpan(
                  text: nounPhrase.adjective == null? '<Adjective> '
                      : '${nounPhrase.adjective} ',
                  style: nounPhrase.adjective == null? unsetTextStyle
                      : TextStyle(color: adjectiveColor),
                ),
                TextSpan(
                  text: nounPhrase.noun == null? '<Noun>' : nounPhrase.noun.toString(),
                  style: nounPhrase.noun == null? unsetTextStyle
                      : TextStyle(color: nounColor),
                ),
              ],
            )),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      if (nounPhrase.allowQuantifierOf)
                        SentenceItemTile(
                          color: quantifierOfColor,
                          label: '<QuantifierOf>',
                          value: nounPhrase.quantifierOfText,
                          trailing: Icon(settingQuantifierOf? Icons.arrow_drop_up : Icons.arrow_drop_down),
                          onTap: toggleEditionQuantifierOf,
                        ),
                      if (nounPhrase.allowQuantifierOf && settingQuantifierOf) SentenceItemField<Determiner>(
                        label: 'QuantifierOf',
                        value: nounPhrase.quantifierOf,
                        options: quantifiers,
                        //displayStringForOption: (option) => option.toString(),
                        onSelected: onQuantifierOfSelected,
                        onChanged: (text) => onQuantifierOfChanged(),
                      ),
                      SentenceItemTile(
                        color: determinerColor,
                        label: '<Determiner>',
                        value: nounPhrase.determiner?.value,
                        trailing: Icon(settingDeterminer? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        onTap: toggleEditionDeterminer,
                        required: true,
                      ),
                      if(settingDeterminer) SentenceItemField<Determiner>(
                        label: 'Determiner',
                        value: nounPhrase.determiner,
                        options: determiners,
                        //displayStringForOption: (option) => option.toString(),
                        onSelected: onDeterminerSelected,
                        onChanged: (text) => onDeterminerChanged(),
                      ),
                      if (nounPhrase.allowNumber)
                        SentenceItemTile(
                          color: numberColor,
                          label: '<Number>',
                          value: nounPhrase.number?.value,
                          trailing: Icon(settingNumber? Icons.arrow_drop_up : Icons.arrow_drop_down),
                          onTap: toggleEditionNumber,
                        ),
                      if(nounPhrase.allowNumber && settingNumber) SentenceItemField<Determiner>(
                        label: 'Number',
                        value: nounPhrase.number,
                        options: allNumbers,
                        //displayStringForOption: (option) => option.toString(),
                        onSelected: onNumberSelected,
                        onChanged: (text) => onNumberChanged(),
                      ),
                      if (nounPhrase.allowAdjective) SentenceItemTile(
                        color: adjectiveColor,
                        label: '<Adjective>',
                        value: nounPhrase.adjective,
                        trailing: Icon(settingAdjective? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        onTap: toggleEditionAdjective,
                      ),
                      if(nounPhrase.allowAdjective && settingAdjective) SentenceItemField<String>(
                        label: 'Adjective',
                        value: nounPhrase.adjective,
                        options: adjectives,
                        //displayStringForOption: (option) => option.toString(),
                        onSelected: onAdjectiveSelected,
                        onChanged: (text) => onAdjectiveChanged(),
                      ),
                      SentenceItemTile(
                        color: nounColor,
                        label: '<Noun>',
                        value: nounPhrase.noun?.value,
                        trailing: Icon(settingNoun? Icons.arrow_drop_up : Icons.arrow_drop_down),
                        onTap: toggleEditionNoun,
                        required: true,
                      ),
                      if(settingNoun) SentenceItemField<Noun>(
                        label: 'Noun',
                        value: nounPhrase.noun,
                        options: nouns,
                        //displayStringForOption: (option) => option.toString(),
                        onSelected: onNounSelected,
                        onChanged: (text) => onNounChanged(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  void onQuantifierOfSelected(Determiner determiner) {
    setQuantifierOf(determiner);
  }

  onQuantifierOfChanged() {
    setQuantifierOf(null);
  }

  void onDeterminerSelected(Determiner determiner) {
    setDeterminer(determiner);
  }

  onDeterminerChanged() {
    setDeterminer(null);
  }

  void onAdjectiveSelected(String adjective) {
    setAdjective(adjective);
  }

  onAdjectiveChanged() {
    setAdjective(null);
  }

  void onNumberSelected(Determiner number) {
    setNumber(number);
  }

  onNumberChanged() {
    setNumber(null);
  }

  void onNounSelected(Noun noun) {
    setNoun(noun);
  }

  onNounChanged() {
    setNoun(null);
  }

  setQuantifierOf(Determiner? quantifierOf) =>
      widget.setNounPhrase(nounPhrase.copyWith(quantifierOf: Nullable(quantifierOf)));

  setDeterminer(Determiner? determiner) =>
      widget.setNounPhrase(nounPhrase.copyWith(determiner: Nullable(determiner)));

  setAdjective(String? adjective) =>
      widget.setNounPhrase(nounPhrase.copyWith(adjective: Nullable(adjective)));

  setNumber(Determiner? number) =>
      widget.setNounPhrase(nounPhrase.copyWith(number: Nullable(number)));

  setNoun(Noun? noun) =>
      widget.setNounPhrase(nounPhrase.copyWith(noun: Nullable(noun)));

  toggleEditionQuantifierOf() => setState(() => settingQuantifierOf = !settingQuantifierOf);
  toggleEditionDeterminer() => setState(() => settingDeterminer = !settingDeterminer);
  toggleEditionAdjective() => setState(() => settingAdjective = !settingAdjective);
  toggleEditionNumber() => setState(() => settingNumber = !settingNumber);
  toggleEditionNoun() => setState(() => settingNoun = !settingNoun);

  NounPhrase get nounPhrase => widget.nounPhrase ?? NounPhrase();

  @override
  void initState() {
    super.initState();
  }
}
