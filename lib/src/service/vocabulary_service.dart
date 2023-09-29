import 'package:flutter/material.dart';

import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/adverb/any_adverb.dart';
import '../model/sentence/adverb/value/adverb_position.dart';
import '../model/sentence/noun/any_noun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/noun/pronoun.dart';
import '../model/sentence/phrase/determiner.dart';
import '../model/sentence/verb/any_verb.dart';
import '../model/sentence/verb/be.dart';
import '../model/sentence/verb/verb.dart';
import '../util/util.dart';

class VocabularyService extends ChangeNotifier {
  static const List<String> possessivePronouns = ['mine','yours','his','hers','its','ours','theirs'];

  // List<Preposition> prepositions() {
  //   return [
  //     Preposition(value: 'to', type: PrepositionType.direction),
  //     Preposition(value: 'since', type: PrepositionType.time),
  //     Preposition(value: 'at', type: PrepositionType.location),
  //     Preposition(value: 'under', type: PrepositionType.space),
  //   ];
  // }

  List<AnyVerb> verbs ()  {
    // final String response = await rootBundle.loadString('assets/irregular-verbs.json');
    // List<Verb> irregularVerbs = await json.decode(response);
    List<AnyVerb> irregularVerbs = [
      Be(),
      Verb(infinitive: 'build', past: 'built', pastParticiple: 'built', isTransitive: true, isDitransitive: false),
      Verb(infinitive: 'buy', past: 'bought', pastParticiple: 'bought', isTransitive: true, isDitransitive: true),
      Verb(infinitive: 'drink', past: 'drank', pastParticiple: 'drunk', isTransitive: true, isDitransitive: false),
      Verb(infinitive: 'eat', past: 'ate', pastParticiple: 'eaten', isTransitive: true, isDitransitive: false),
      Verb(infinitive: 'forget', past: 'forgot', pastParticiple: 'forgotten', isTransitive: true, isDitransitive: false),
    ];
    return irregularVerbs;
  }

  List<Pronoun> subjectPronouns() {
    const List<String> doers = ['I','you','he','she','it','we','they'];
    return doers.map((e) => Pronoun(e)).toList();
  }

  List<Pronoun> objectPronouns() {
    const List<String> receivers = ['me','you','him','her','it','us','them'];
    return receivers.map((e) => Pronoun(e)).toList();
  }

  List<Determiner> articles(Noun? noun) {
    List<Determiner> articles = [
      Determiner.article('a', false, true, false),
      Determiner.article('an', false, true, false),
      Determiner.article('the', true, true, true),
    ];
    if (noun == null) {
      return articles;
    }
    bool nounStartsWithVowel = Util.isVowel(noun.value.substring(0,1));
    bool isSingular = noun.countability == Countability.singular;
    print('nounStartsWithVowel: $nounStartsWithVowel');
    if (isSingular && nounStartsWithVowel) {
      return [articles[1], articles.last];
    } else if (isSingular && !nounStartsWithVowel) {
      return [articles.first, articles.last];
    }
    return [articles.last];
  }

  List<Determiner> possessives() {
    return [
      Determiner.possessive('my'),
      Determiner.possessive('your'),
      Determiner.possessive('his'),
      Determiner.possessive('her'),
      Determiner.possessive('its'),
      Determiner.possessive('our'),
      Determiner.possessive('their'),
    ];
  }

  List<Determiner> demonstratives(Noun? noun) {
    List<Determiner> demonstratrives = [
      Determiner.demonstrative('this', true, true, false),
      Determiner.demonstrative('that', true, true, false),
      Determiner.demonstrative('these', false, false, true),
      Determiner.demonstrative('those', false, false, true),
    ];
    if (noun == null) {
      return demonstratrives;
    }
    return demonstratrives.where((e)
    => noun.countability == Countability.uncountable && e.allowsUncountable
        || noun.countability == Countability.singular && e.allowsSingular
        || noun.countability == Countability.plural && e.allowsPlural
    ).toList();
  }

  List<Determiner> distributives(Noun? noun) {
    List<Determiner> distributives = [
      Determiner.distributive('each', false, true, false),
      Determiner.distributive('every', false, true, false),
      Determiner.distributive('either', false, true, true),
      Determiner.distributive('neither', false, true, true),
      Determiner.distributive('any', true, true, true),
      Determiner.distributive('both', false, false, true),
    ];
    if (noun == null) {
      return distributives;
    }
    return distributives.where((e)
    => noun.countability == Countability.uncountable && e.allowsUncountable
        || noun.countability == Countability.singular && e.allowsSingular
        || noun.countability == Countability.plural && e.allowsPlural
    ).toList();
  }

  List<Determiner> quantifiers(Noun? noun) {
    List<Determiner> quantifiers = [
      Determiner.quantifier('some', true, true, true),
      Determiner.quantifier('many', false, false, true),
      Determiner.quantifier('a few', false, false, true),
      Determiner.quantifier('the few', false, false, true),
      Determiner.quantifier('a lot of', true, false, true),
      Determiner.quantifier('several', false, false, true),
    ];
    if (noun == null) {
      return quantifiers;
    }
    return quantifiers.where((e)
    => noun.countability == Countability.uncountable && e.allowsUncountable
        || noun.countability == Countability.singular && e.allowsSingular
        || noun.countability == Countability.plural && e.allowsPlural
    ).toList();
  }

  List<Determiner> numbers(Noun? noun, [bool includeOrdinalNumbers = false]) {
    List<Determiner> ordinalNumbers = [
      Determiner.ordinalNumber('first'),
      Determiner.ordinalNumber('second'),
      Determiner.ordinalNumber('third'),
      Determiner.ordinalNumber('fourth'),
      Determiner.ordinalNumber('fifth'),
      Determiner.ordinalNumber('sixth'),
      Determiner.ordinalNumber('seventh'),
      Determiner.ordinalNumber('eighth'),
      Determiner.ordinalNumber('nineth'),
      Determiner.ordinalNumber('tenth'),
      Determiner.ordinalNumber('eleventh'),
      Determiner.ordinalNumber('twelfth'),
      Determiner.ordinalNumber('thirteenth'),
      Determiner.ordinalNumber('fourteenth'),
      Determiner.ordinalNumber('fifteenth'),
      Determiner.ordinalNumber('sixteenth'),
      Determiner.ordinalNumber('seventeenth'),
      Determiner.ordinalNumber('eighteenth'),
      Determiner.ordinalNumber('nineteenth'),
      Determiner.ordinalNumber('twentieth'),
    ];
    List<Determiner> naturalNumbers = [
      Determiner.one(),
      Determiner.naturalNumber('two'),
      Determiner.naturalNumber('three'),
      Determiner.naturalNumber('four'),
      Determiner.naturalNumber('five'),
      Determiner.naturalNumber('six'),
      Determiner.naturalNumber('seven'),
      Determiner.naturalNumber('eight'),
      Determiner.naturalNumber('nine'),
      Determiner.naturalNumber('ten'),
      Determiner.naturalNumber('eleven'),
      Determiner.naturalNumber('twelve'),
      Determiner.naturalNumber('thirteen'),
      Determiner.naturalNumber('fourteen'),
      Determiner.naturalNumber('fifteen'),
      Determiner.naturalNumber('sixteen'),
      Determiner.naturalNumber('seventeen'),
      Determiner.naturalNumber('eighteen'),
      Determiner.naturalNumber('nineteen'),
      Determiner.naturalNumber('twenty'),
    ];
    if (noun == null) {
      return [
        ...naturalNumbers,
        if (includeOrdinalNumbers) ...ordinalNumbers,
      ];
    }
    return [...naturalNumbers.where((e)
    => noun.countability == Countability.uncountable && e.allowsUncountable
        || noun.countability == Countability.singular && e.allowsSingular
        || noun.countability == Countability.plural && e.allowsPlural
    ).toList(),
      if (includeOrdinalNumbers && noun.countability == Countability.singular)
        ...ordinalNumbers,
    ];
  }

  List<String> adjectives() {
    return ['beautiful', 'small','big','intelligent','round','lazy','old'];
  }

  List<Noun> nouns(Determiner? determiner) {
    List<Noun> nouns = [
      Noun('pet', Countability.singular),
      Noun('pets', Countability.plural),
      Noun('water', Countability.uncountable),
    ];
    if (determiner == null) {
      return nouns;
    }
    return nouns.where((e) {
      return e.countability == Countability.uncountable && determiner.allowsUncountable
          || e.countability == Countability.singular && determiner.allowsSingular
          || e.countability == Countability.plural && determiner.allowsPlural;
    }).toList();
  }

  List<Adverb> allAdverbs = [
    Adverb.manner('quickly'),
    Adverb.place('here'),
    Adverb.place('there'),
    Adverb.place('outside'),
    Adverb.time('today'),
    Adverb.time('tomorrow'),
    Adverb.duration('long'),
    Adverb.frequency('always', {AdverbPosition.mid, AdverbPosition.end}),
    Adverb.frequency('usually'),
    Adverb.frequency('normally'),
    Adverb.frequency('often'),
    Adverb.frequency('sometimes'),
    Adverb.frequency('occasionally'),
    Adverb.frequency('rarely'),
    Adverb.frequency('never', {AdverbPosition.mid, AdverbPosition.end}),
    Adverb.degree('really', {AdverbPosition.mid}),
    Adverb.degree('very', {AdverbPosition.mid}),
    Adverb.degree('quite', {AdverbPosition.mid}),
    Adverb.degree('a lot', {AdverbPosition.end}),
    Adverb.degree('a bit', {AdverbPosition.end}),
    Adverb.focusing('simply'),
    Adverb.certainty('probably', {AdverbPosition.mid}),
    Adverb.certainty('possibly', {AdverbPosition.mid}),
    Adverb.certainty('certainly', {AdverbPosition.mid}),
    Adverb.certainty('maybe', {AdverbPosition.front, AdverbPosition.end}),
    Adverb.certainty('perhaps', {AdverbPosition.front, AdverbPosition.end}),
    Adverb.viewpoint('personally'),
    Adverb.viewpoint('frankly'),
    Adverb.evaluative('unfortunately'),
  ];

  List<AnyAdverb> frontAdverbs() =>
    allAdverbs.where((adverb) => adverb.positions.contains(AdverbPosition.front))
        .toList();

  List<AnyAdverb> midAdverbs() =>
      allAdverbs.where((adverb) => adverb.positions.contains(AdverbPosition.mid))
          .toList();

  List<AnyAdverb> endAdverbs() =>
      allAdverbs.where((adverb) => adverb.positions.contains(AdverbPosition.end))
          .toList();
}
