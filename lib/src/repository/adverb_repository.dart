import 'package:flutter/cupertino.dart';

import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/adverb/value/adverb_position.dart';

class AdverbRepository extends ChangeNotifier {
  List<Adverb> allAdverbs = [
    Adverb.manner('quickly', 'rápidamente'),
    Adverb.place('here', 'aquí'),
    Adverb.place('there', 'allá'),
    Adverb.place('outside', 'afuera'),
    Adverb.time('today', 'hoy'),
    Adverb.time('tomorrow', 'mañana'),
    Adverb.duration('long', 'mucho tiempo'),
    Adverb.frequency(
        'always', 'siempre', {AdverbPosition.mid, AdverbPosition.end}),
    Adverb.frequency('usually', 'usualmente'),
    Adverb.frequency('normally', 'normalmente'),
    Adverb.frequency('often', 'a menudo'),
    Adverb.frequency('sometimes', 'algunas veces'),
    Adverb.frequency('occasionally', 'ocasionalmente'),
    Adverb.frequency('rarely', 'raramente'),
    Adverb.frequency(
        'never', 'nunca', {AdverbPosition.mid, AdverbPosition.end}),
    Adverb.degree('really', 'realmente', {AdverbPosition.mid}),
    Adverb.degree('very', 'muy', {AdverbPosition.mid}),
    Adverb.degree('quite', 'bastante', {AdverbPosition.mid}),
    Adverb.degree('a lot', 'mucho', {AdverbPosition.end}),
    Adverb.degree('a bit', 'un poco', {AdverbPosition.end}),
    Adverb.focusing('simply', 'simplemente'),
    Adverb.certainty('probably', 'probablemente', {AdverbPosition.mid}),
    Adverb.certainty('possibly', 'posiblemente', {AdverbPosition.mid}),
    Adverb.certainty('certainly', 'ciertamente', {AdverbPosition.mid}),
    Adverb.certainty(
        'maybe', 'tal vez', {AdverbPosition.front, AdverbPosition.end}),
    Adverb.certainty(
        'perhaps', 'tal vez', {AdverbPosition.front, AdverbPosition.end}),
    Adverb.viewpoint('personally', 'personalmente'),
    Adverb.viewpoint('frankly', 'francamente'),
    Adverb.evaluative('unfortunately', 'desafortunadamente'),
  ];

  List<Adverb> frontAdverbs() => allAdverbs
      .where((adverb) => adverb.positions.contains(AdverbPosition.front))
      .toList();

  List<Adverb> midAdverbs() => allAdverbs
      .where((adverb) => adverb.positions.contains(AdverbPosition.mid))
      .toList();

  List<Adverb> endAdverbs() => allAdverbs
      .where((adverb) => adverb.positions.contains(AdverbPosition.end))
      .toList();
}
