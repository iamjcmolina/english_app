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
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import '../../page/adjectival_phrase_page.dart';

class NounPhraseForm extends StatefulWidget {
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
  State<NounPhraseForm> createState() => _NounPhraseFormState();
}

class _NounPhraseFormState extends State<NounPhraseForm> {
  bool isQuantifierFieldShown = false;
  bool isDeterminerFieldShown = false;
  bool isNumberFieldShown = false;
  bool isAdjectiveFieldShown = false;
  bool isNounFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        widget.settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: widget.phrase.allowQuantifier
                    ? widget.phrase.quantifierOf?.addSpace()
                    : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: (widget.phrase.determiner?.en ?? Label.determiner)
                    .addSpace(),
                style: widget.phrase.determiner == null
                    ? Word.empty.style
                    : Word.determiner.style,
              ),
              TextSpan(
                text: widget.phrase.allowNumber
                    ? widget.phrase.number?.en.addSpace()
                    : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: widget.phrase.allowAdjective
                    ? widget.phrase.adjective?.en.addSpace()
                    : null,
                style: Word.adjective.style,
              ),
              TextSpan(
                text: (widget.phrase.noun?.en ?? Label.noun).addSpace(),
                style: widget.phrase.noun == null
                    ? Word.empty.style
                    : Word.noun.style,
              ),
              TextSpan(
                text: widget.phrase.adjectivalPhrase?.en,
                style: Word.adjective.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: widget.phrase.allowQuantifier
                    ? widget.phrase.quantifierOfEs?.addSpace()
                    : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: (widget.phrase.determiner?.es ?? Label.determinerEs)
                    .addSpace(),
                style: widget.phrase.determiner == null
                    ? Word.empty.style
                    : Word.determiner.style,
              ),
              TextSpan(
                text: widget.phrase.allowNumber
                    ? widget.phrase.number?.es.addSpace()
                    : null,
                style: Word.determiner.style,
              ),
              TextSpan(
                text: (widget.phrase.noun?.es ?? Label.nounEs).addSpace(),
                style: widget.phrase.noun == null
                    ? Word.empty.style
                    : Word.noun.style,
              ),
              TextSpan(
                text: widget.phrase.allowAdjective
                    ? widget.phrase.adjective
                        ?.toEs(widget.phrase.noun?.isPlural)
                        .addSpace()
                    : null,
                style: Word.adjective.style,
              ),
              TextSpan(
                text: widget.phrase.adjectivalPhrase
                    ?.toEs(widget.phrase.noun?.isPlural),
                style: Word.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        if (!isQuantifierFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleQuantifierField,
            style: Word.determiner.style,
            placeholder: Label.quantifier,
            en: widget.phrase.quantifierOf,
            es: widget.phrase.quantifierOfEs,
            isShown: widget.phrase.allowQuantifier,
          ),
        if (isQuantifierFieldShown)
          ItemField<Determiner>(
            label: Label.quantifier,
            options: vocabularyRepository.quantifiers(widget.phrase.noun),
            value: widget.phrase.quantifier,
            setValue: setQuantifier,
            toEnString: (Determiner e) => e.en,
            toEsString: (Determiner e) => e.es,
            getHelperText: (e) => e.help,
            onAccept: toggleQuantifierField,
          ),
        // bool isDeterminerFieldShown = false;
        if (!isDeterminerFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleDeterminerField,
            style: Word.determiner.style,
            placeholder: Label.determiner,
            en: widget.phrase.determiner?.en,
            es: widget.phrase.determiner?.es,
            isRequired: true,
          ),
        if (isDeterminerFieldShown)
          ItemField<Determiner>(
            label: Label.determiner,
            options: determiners(vocabularyRepository),
            value: widget.phrase.determiner,
            setValue: setDeterminer,
            toEnString: (Determiner e) => e.en,
            toEsString: (Determiner e) => e.es,
            getHelperText: (e) => e.help,
            onAccept: toggleDeterminerField,
          ),
        // bool isNumberFieldShown = false;
        if (!isNumberFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleNumberField,
            style: Word.determiner.style,
            placeholder: Label.number,
            en: widget.phrase.number?.en,
            es: widget.phrase.number?.es,
            isShown: widget.phrase.allowNumber,
          ),
        if (isNumberFieldShown)
          ItemField<Determiner>(
            label: Label.number,
            options: vocabularyRepository.numbers(widget.phrase.noun, true),
            value: widget.phrase.number,
            setValue: setNumber,
            toEnString: (Determiner e) => e.en,
            toEsString: (Determiner e) => e.es,
            getHelperText: (e) => e.help,
            onAccept: toggleNumberField,
          ),
        // bool isAdjectiveFieldShown = false;
        if (!isAdjectiveFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleAdjectiveField,
            style: Word.adjective.style,
            placeholder: Label.adjective,
            en: widget.phrase.adjective?.en,
            es: widget.phrase.adjective?.toEs(widget.phrase.isPlural),
            isShown: widget.phrase.allowAdjective,
          ),
        if (isAdjectiveFieldShown)
          ItemField<Adjective>(
            label: Label.adjective,
            options: vocabularyRepository.adjectives(),
            value: widget.phrase.adjective,
            setValue: setAdjective,
            toEnString: (Adjective e) => e.en,
            toEsString: (Adjective e) => e.toEs(),
            onAccept: toggleAdjectiveField,
          ),
        // bool isNounFieldShown = false;
        if (!isNounFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleNounField,
            style: Word.noun.style,
            placeholder: Label.noun,
            en: widget.phrase.noun?.en,
            es: widget.phrase.noun?.es,
            isRequired: true,
          ),
        if (isNounFieldShown)
          ItemField<Noun>(
            label: Label.noun,
            options: vocabularyRepository.nouns(widget.phrase.determiner),
            value: widget.phrase.noun,
            setValue: setNoun,
            toEnString: (Noun e) => e.en,
            toEsString: (Noun e) => e.es,
            onAccept: toggleNounField,
          ),
        ItemTile(
          style: Word.adjective.style,
          placeholder: Label.adjectivalPhrase,
          en: widget.phrase.adjectivalPhrase?.en,
          es: widget.phrase.adjectivalPhrase
              ?.toEs(widget.phrase.noun?.isPlural),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToAdjectivalPhrasePage(context),
        ),
      ],
    );
  }

  setQuantifier(quantifierOf) => widget
      .setPhrase(widget.phrase.copyWith(quantifier: Nullable(quantifierOf)));

  setDeterminer(determiner) => widget
      .setPhrase(widget.phrase.copyWith(determiner: Nullable(determiner)));

  setAdjective(adjective) =>
      widget.setPhrase(widget.phrase.copyWith(adjective: Nullable(adjective)));

  setNumber(number) =>
      widget.setPhrase(widget.phrase.copyWith(number: Nullable(number)));

  setNoun(noun) =>
      widget.setPhrase(widget.phrase.copyWith(noun: Nullable(noun)));

  setAdjectivalPhrase(AnyAdjective? adjective) => widget
      .setPhrase(widget.phrase.copyWith(adjectivalPhrase: Nullable(adjective)));

  List<Determiner> determiners(VocabularyRepository vocabularyRepository) => [
        ...vocabularyRepository.articles(widget.phrase.noun),
        ...vocabularyRepository.possessiveAdjectives(),
        ...vocabularyRepository.demonstrativeAdjectives(widget.phrase.noun),
        ...vocabularyRepository.distributiveAdjectives(widget.phrase.noun),
        ...vocabularyRepository.quantifiers(widget.phrase.noun),
        ...vocabularyRepository.numbers(widget.phrase.noun)
      ];

  void goToAdjectivalPhrasePage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdjectivalPhrasePage(
                  adjective: widget.phrase.adjectivalPhrase,
                  isNegative: widget.isNegative,
                  isPlural: widget.isPlural,
                )));
    if (response != null) {
      setAdjectivalPhrase(response is AnyAdjective ? response : null);
    }
  }

  toggleQuantifierField() =>
      setState(() => isQuantifierFieldShown = !isQuantifierFieldShown);

  toggleDeterminerField() =>
      setState(() => isDeterminerFieldShown = !isDeterminerFieldShown);

  toggleNumberField() =>
      setState(() => isNumberFieldShown = !isNumberFieldShown);

  toggleAdjectiveField() =>
      setState(() => isAdjectiveFieldShown = !isAdjectiveFieldShown);

  toggleNounField() => setState(() => isNounFieldShown = !isNounFieldShown);
}
