import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../model/sentence/adjective/adjective.dart';
import '../model/sentence/adverb/adverb.dart';
import '../model/sentence/determiner/determiner.dart';
import '../model/sentence/noun/countability.dart';
import '../model/sentence/noun/indefinite_pronoun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/preposition/preposition.dart';
import '../model/sentence/verb/phrasal_verb.dart';
import '../model/sentence/verb/verb.dart';

class VocabularyProvider extends ChangeNotifier {
  final List<Determiner> distributiveAdjectives = [];
  final List<Determiner> quantifiers = [];
  final List<Determiner> ordinalNumbers = [];
  final List<Determiner> naturalNumbers = [];
  final List<Adjective> adjectives = [];
  final List<Noun> nouns = [];
  final List<IndefinitePronoun> indefinitePronouns = [];
  final List<Preposition> prepositions = [];
  final List<Adverb> mannerAdverbs = [];
  final List<Adverb> placeAdverbs = [];
  final List<Adverb> timeAdverbs = [];
  final List<Adverb> durationAdverbs = [];
  final List<Adverb> degreeAdverbs = [];
  final List<Adverb> focusingAdverbs = [];
  final List<Adverb> certaintyAdverbs = [];
  final List<Adverb> viewpointAdverbs = [];
  final List<Adverb> evaluativeAdverbs = [];
  final List<Verb> verbs = [];
  final List<PhrasalVerb> phrasalVerbs = [];
  final BuildContext context;

  VocabularyProvider(this.context) {
    _loadData();
  }

  void _loadData() async {
    distributiveAdjectives.addAll(await _getDistributiveAdjectives());
    quantifiers.addAll(await _getQuantifiers());
    ordinalNumbers.addAll(await _getOrdinalNumbers());
    naturalNumbers.addAll(await _getNaturalNumbers());
    adjectives.addAll(await _getAdjectives());
    nouns.addAll(await _getNouns());
    indefinitePronouns.addAll(await _getIndefinitePronouns());
    mannerAdverbs.addAll(await _getMannerAdverbs());
    placeAdverbs.addAll(await _getPlaceAdverbs());
    timeAdverbs.addAll(await _getTimeAdverbs());
    durationAdverbs.addAll(await _getDurationAdverbs());
    degreeAdverbs.addAll(await _getDegreeAdverbs());
    focusingAdverbs.addAll(await _getFocusingAdverbs());
    certaintyAdverbs.addAll(await _getCertaintyAdverbs());
    viewpointAdverbs.addAll(await _getViewpointAdverbs());
    evaluativeAdverbs.addAll(await _getEvaluativeAdverbs());
    prepositions.addAll(await getPrepositions());
    phrasalVerbs.addAll(await _getPhrasalVerbs());
    verbs.addAll(await _getVerbs());
    notifyListeners();
  }

  Future<List<Determiner>> _getDistributiveAdjectives() async {
    final rows = await _getCsvData('determiners/distributive-adjectives');
    return rows
        .map((row) => Determiner.distributiveAdjective(
            row[0], row[1], row[2] == 1, row[3] == 1, row[4] == 1))
        .toList();
  }

  Future<List<Determiner>> _getQuantifiers() async {
    final rows = await _getCsvData('determiners/quantifiers');
    return rows
        .map((row) => Determiner.quantifier(
            row[0], row[1], row[2] == 1, row[3] == 1, row[4] == 1))
        .toList();
  }

  Future<List<Determiner>> _getOrdinalNumbers() async {
    final rows = await _getCsvData('determiners/ordinal-numbers');
    return rows.map((row) => Determiner.ordinalNumber(row[0], row[1])).toList();
  }

  Future<List<Determiner>> _getNaturalNumbers() async {
    final rows = await _getCsvData('determiners/natural-numbers');
    return rows.map((row) => Determiner.naturalNumber(row[0], row[1])).toList();
  }

  Future<List<Adjective>> _getAdjectives() async {
    final rows = await _getCsvData('adjectives');
    return rows.map((row) => Adjective(row[0], row[1], row[2])).toList();
  }

  Future<List<IndefinitePronoun>> _getIndefinitePronouns() async {
    final rows = await _getCsvData('nouns/indefinite-pronouns');
    return rows
        .map((row) => IndefinitePronoun(
              row[0],
              row[1],
              switch (row[2]) {
                'singular' => Countability.singular,
                'plural' => Countability.plural,
                _ => Countability.uncountable,
              },
              switch (row[3]) {
                'singular' => Countability.singular,
                'plural' => Countability.plural,
                _ => Countability.uncountable,
              },
              row[4],
            ))
        .toList();
  }

  Future<List<Noun>> _getNouns() async {
    final rows = await _getCsvData('nouns/nouns');
    return rows
        .map((row) => Noun(
              row[0],
              row[1],
              switch (row[2]) {
                'singular' => Countability.singular,
                'plural' => Countability.plural,
                _ => Countability.uncountable,
              },
            ))
        .toList();
  }

  Future<List<Adverb>> _getMannerAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/manner');
    return rows.map((row) => Adverb.manner(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getPlaceAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/place');
    return rows.map((row) => Adverb.place(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getTimeAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/time');
    return rows.map((row) => Adverb.time(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getDurationAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/duration');
    return rows.map((row) => Adverb.duration(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getDegreeAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/degree');
    return rows
        .map((row) => Adverb.degree(
            row[0], row[1], row[2] == 1, row[3] == 1, row[4] == 1))
        .toList();
  }

  Future<List<Adverb>> _getFocusingAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/focusing');
    return rows.map((row) => Adverb.focusing(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getCertaintyAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/certainty');
    return rows
        .map((row) => Adverb.certainty(
            row[0], row[1], row[2] == 1, row[3] == 1, row[4] == 1))
        .toList();
  }

  Future<List<Adverb>> _getViewpointAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/viewpoint');
    return rows.map((row) => Adverb.viewpoint(row[0], row[1])).toList();
  }

  Future<List<Adverb>> _getEvaluativeAdverbs() async {
    List<List<dynamic>> rows = await _getCsvData('adverbs/evaluative');
    return rows.map((row) => Adverb.evaluative(row[0], row[1])).toList();
  }

  Future<List<Preposition>> getPrepositions() async {
    final rows = await _getCsvData('prepositions');
    return rows.map((row) => Preposition(en: row[0], es: row[1])).toList();
  }

  Future<List<PhrasalVerb>> _getPhrasalVerbs() async {
    final rows = await _getCsvData('verbs/phrasal-verbs');
    return rows
        .map((row) => PhrasalVerb(
              infinitive: row[0],
              past: row[1],
              pastParticiple: row[2],
              particle: row[3],
              infinitiveEs: row[4],
              pastParticipleEs: row[5],
              progressiveEs: row[6],
              presentHeEs: row[7],
              pastIEs: row[8],
              pastWeEs: row[9],
              isSeparable: row[10] == 1,
              isTransitive: row[11] == 1,
              isDitransitive: row[12] == 1,
            ))
        .toList();
  }

  Future<List<Verb>> _getVerbs() async {
    final rows = await _getCsvData('verbs/verbs');
    return rows
        .map((row) => Verb(
              infinitive: row[0],
              past: row[1],
              pastParticiple: row[2],
              infinitiveEs: row[3],
              pastParticipleEs: row[4],
              progressiveEs: row[5],
              presentHeEs: row[6],
              pastIEs: row[7],
              pastWeEs: row[8],
              isTransitive: row[9] == 1,
              isDitransitive: row[10] == 1,
              isLinkingVerb: row[11] == 1,
            ))
        .toList();
  }

  Future<List<List<dynamic>>> _getCsvData(String filename) async {
    final text = await DefaultAssetBundle.of(context).loadString(
      "assets/vocabulary/$filename.csv",
    );
    return const CsvToListConverter()
        .convert(text)
        .skip(1)
        .where((element) => element.length > 1)
        .toList();
  }
}
