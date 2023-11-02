import 'package:flutter/material.dart';

import '../extensions/string_extension.dart';
import '../model/sentence/adjective/adjective.dart';
import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/determiner/determiner.dart';
import '../model/sentence/noun/indefinite_pronoun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/noun/pronoun.dart';
import '../model/sentence/preposition/preposition.dart';
import '../model/sentence/verb/any_verb.dart';
import '../model/sentence/verb/be.dart';
import '../model/sentence/verb/modal_verb.dart';
import '../model/sentence/verb/phrasal_verb.dart';
import '../model/sentence/verb/verb.dart';
import 'vocabulary_provider.dart';

class VocabularyRepository extends ChangeNotifier {
  final VocabularyProvider provider;

  VocabularyRepository(this.provider);

  List<Pronoun> subjectPronouns() => Pronoun.subjectPronouns;

  List<Pronoun> objectPronouns() => Pronoun.objectPronouns;

  List<Pronoun> possessivePronouns() => Pronoun.possessivePronouns;

  List<Determiner> possessiveAdjectives() => Determiner.possessiveAdjectives;

  List<ModalVerb> modalVerbs() => ModalVerb.modalVerbs;

  List<Determiner> articles(Noun? noun) => noun == null
      ? Determiner.articles
      : noun.isPlural
          ? Determiner.articles.where((e) => e.en == 'the').toList()
          : noun.en.first().isVowel
              ? Determiner.articles.where((e) => e.en != 'a').toList()
              : Determiner.articles.where((e) => e.en != 'an').toList();

  List<Determiner> demonstrativeAdjectives(Noun? noun) => noun == null
      ? Determiner.demonstrativeAdjectives
      : Determiner.demonstrativeAdjectives
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> distributiveAdjectives(Noun? noun) => noun == null
      ? provider.distributiveAdjectives
      : provider.distributiveAdjectives
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> quantifiers(Noun? noun) => noun == null
      ? provider.quantifiers
      : provider.quantifiers
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> numbers(Noun? noun, [bool includeOrdinalNumbers = false]) =>
      noun == null
          ? [
              ...provider.naturalNumbers,
              if (includeOrdinalNumbers) ...provider.ordinalNumbers,
            ]
          : [
              ...provider.naturalNumbers
                  .where((e) =>
                      noun.isUncountable && e.isUncountableAllowed ||
                      noun.isSingular && e.isSingularAllowed ||
                      noun.isPlural && e.isPluralAllowed)
                  .toList(),
              if (includeOrdinalNumbers && !noun.isPlural)
                ...provider.ordinalNumbers,
            ];

  List<Preposition> prepositions() => provider.prepositions;

  List<Adjective> adjectives() => provider.adjectives;

  List<Noun> nouns(Determiner? determiner) => determiner == null
      ? provider.nouns
      : provider.nouns.where((e) {
          return e.isUncountable && determiner.isUncountableAllowed ||
              e.isSingular && determiner.isSingularAllowed ||
              e.isPlural && determiner.isPluralAllowed;
        }).toList();

  List<IndefinitePronoun> indefinitePronouns(bool isNegative) =>
      provider.indefinitePronouns
          .where((e) => e.isNegativeOnlyAllowed == isNegative)
          .toList();

  List<AnyVerb> verbs() =>
      [Be.ser, ...provider.verbs, ...provider.phrasalVerbs];

  List<Verb> actionVerbs() =>
      provider.verbs.where((e) => !e.isLinkingVerb).toList();

  List<PhrasalVerb> phrasalVerbs() => provider.phrasalVerbs;

  List<Adverb> adverbs() => [
        ...provider.certaintyAdverbs,
        ...provider.degreeAdverbs,
        ...provider.durationAdverbs,
        ...provider.evaluativeAdverbs,
        ...provider.focusingAdverbs,
        ...provider.mannerAdverbs,
        ...provider.placeAdverbs,
        ...provider.timeAdverbs,
        ...provider.viewpointAdverbs,
      ];

  List<Adverb> frontAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInFront).toList();

  List<Adverb> midAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInTheMiddle).toList();

  List<Adverb> endAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInTheEnd).toList();
}
