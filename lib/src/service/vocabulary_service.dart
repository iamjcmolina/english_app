import 'package:flutter/material.dart';

import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/adverb/any_adverb.dart';
import '../model/sentence/adverb/value/adverb_position.dart';
import '../model/sentence/noun/pronoun.dart';
import '../model/sentence/verb/any_verb.dart';
import '../model/sentence/verb/be.dart';
import '../model/sentence/verb/verb.dart';

class VocabularyService extends ChangeNotifier {
  static const List<String> possesiveAdjectives = ['my','your','his','her','its','our','their'];
  static const List<String> possesivePronouns = ['mine','yours','his','hers','its','ours','theirs'];
  static const List<String> singularDemonstratives = ['this','these','that','those'];
  static const List<String> pluralDemonstratives = ['this','these','that','those'];
  static const List<String> distributiveAdjectives = ['each','every','either','neither','any','both'];
  static const List<String> quantifiers = ['some','many','a few','the few','a lot of','several'];
  static const List<String> numbers = ['one','two','three','four','five','six', 'seven', 'eight', 'nine', 'ten'
    ,'eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen','twenty'];
  static const List<String> ordinalNumbers = [
    'first','second','third','fourth','fifth','sixth', 'seventh', 'eighth', 'nineth', 'tenth',
    'eleventh', 'twelfth', 'thirteenth','fourteenth','fifteenth','sixteenth','seventeenth','eighteenth','nineteenth','twentieth'];
  static const List<String> doers = ['I','you','he','she','it','we','they'];
  static const List<String> receivers = ['me','you','him','her','it','us','them'];
  static const List<String> articles = ['the','a','an'];

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
    return doers.map((e) => Pronoun(e)).toList();
  }

  // List<String> determiners(Noun noun) {
  //   return [
  //     ...(noun.isCountable? articles : ['the']),
  //     ...distributiveAdjectives,
  //     ...(noun.isSingular? singularDemonstratives : pluralDemonstratives),
  //     ...(noun.isCountable? possesiveAdjectives : []),
  //     ...(!noun.isCountable? [] : noun.isSingular? ['one'] : numbers.where((number) => number!='one')),
  //     ...quantifiers,
  //   ];
  // }


  List<String> adjectives({bool adjectivalPhrase = false}) {
    return [
      'beautiful',
      ...adjectivalPhrase? [] : ordinalNumbers,
    ];
  }

  // List<Noun> nouns() {
  //   return [
  //     Noun.countable(isSingular: true, value: 'pet'),
  //     Noun.countable(isSingular: false, value: 'pets'),
  //     Noun.uncountable('water'),
  //   ];
  // }

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
