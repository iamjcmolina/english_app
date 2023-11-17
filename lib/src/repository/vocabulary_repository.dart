import 'package:flutter/material.dart';

import '../extensions/string_extension.dart';
import '../model/sentence/adjective/adjective.dart';
import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/determiner/determiner.dart';
import '../model/sentence/noun/indefinite_pronoun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/noun/object_pronoun.dart';
import '../model/sentence/noun/possessive_pronoun.dart';
import '../model/sentence/noun/subject_pronoun.dart';
import '../model/sentence/preposition/preposition.dart';
import '../model/sentence/verb/any_verb.dart';
import '../model/sentence/verb/be.dart';
import '../model/sentence/verb/have.dart';
import '../model/sentence/verb/modal_verb.dart';
import '../model/sentence/verb/phrasal_verb.dart';
import '../model/sentence/verb/verb.dart';
import 'vocabulary_provider.dart';

class VocabularyRepository extends ChangeNotifier {
  final VocabularyProvider provider;

  VocabularyRepository(this.provider);

  List<SubjectPronoun> subjectPronouns() => SubjectPronoun.subjectPronouns;

  List<ObjectPronoun> objectPronouns() => ObjectPronoun.objectPronouns;

  List<PossessivePronoun> possessivePronouns() =>
      PossessivePronoun.possessivePronouns;

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
              noun.isUncountable && e.allowsUncountable ||
              noun.isSingular && e.allowsSingular ||
              noun.isPlural && e.allowsPlural)
          .toList();

  List<Determiner> distributiveAdjectives(Noun? noun) => noun == null
      ? provider.distributiveAdjectives
      : provider.distributiveAdjectives
          .where((e) =>
              noun.isUncountable && e.allowsUncountable ||
              noun.isSingular && e.allowsSingular ||
              noun.isPlural && e.allowsPlural)
          .toList();

  List<Determiner> quantifiers(Noun? noun) => noun == null
      ? provider.quantifiers
      : provider.quantifiers
          .where((e) =>
              noun.isUncountable && e.allowsUncountable ||
              noun.isSingular && e.allowsSingular ||
              noun.isPlural && e.allowsPlural)
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
                      noun.isUncountable && e.allowsUncountable ||
                      noun.isSingular && e.allowsSingular ||
                      noun.isPlural && e.allowsPlural)
                  .toList(),
              if (includeOrdinalNumbers && !noun.isPlural)
                ...provider.ordinalNumbers,
            ];

  List<Preposition> prepositions() => provider.prepositions;

  List<Adjective> adjectives() => provider.adjectives;

  List<Noun> nouns(Determiner? determiner) => determiner == null
      ? provider.nouns
      : provider.nouns
          .where((e) => determiner.en == 'a'
              ? e.isSingular && e.en.first().isConsonant
              : determiner.en == 'an'
                  ? e.isSingular && e.en.first().isVowel
                  : determiner.allowsUncountable && e.isUncountable ||
                      determiner.allowsSingular && e.isSingular ||
                      determiner.allowsPlural && e.isPlural)
          .toList();

  List<IndefinitePronoun> indefinitePronouns(bool isNegative) =>
      provider.indefinitePronouns
          .where((e) => e.isNegativeOnlyAllowed == isNegative)
          .toList();

  List<AnyVerb> verbs() =>
      [Be.ser, Have.tener, ...provider.verbs, ...provider.phrasalVerbs];

  List<Verb> actionVerbs() =>
      provider.verbs.where((e) => !e.canBeLinkingVerb).toList();

  List<PhrasalVerb> phrasalVerbs() => provider.phrasalVerbs;

  List<Adverb> adverbs() => [
        ...Adverb.frequencyAdverbs,
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

  List<Adverb> degreeAdverbs() => provider.degreeAdverbs;
}
