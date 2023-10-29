import '../model/sentence/adjective/adjective.dart';
import '../model/sentence/noun/any_noun.dart';
import '../model/sentence/noun/indefinite_pronoun.dart';
import '../model/sentence/noun/noun.dart';
import '../model/sentence/noun/pronoun.dart';
import '../model/sentence/phrase/determiner.dart';
import '../util/util.dart';
import 'vocabulary_provider.dart';

class NounRepository extends VocabularyProvider {
  static const List<Pronoun> _subjectPronouns = [
    Pronoun('I', 'yo', DoerPronoun.I),
    Pronoun('you', 'tu/ustedes', DoerPronoun.you),
    Pronoun('he', 'él', DoerPronoun.he),
    Pronoun('she', 'ella', DoerPronoun.she),
    Pronoun('it', 'eso', DoerPronoun.it),
    Pronoun('we', 'nosotros', DoerPronoun.we),
    Pronoun('they', 'ellos', DoerPronoun.they)
  ];
  static const List<Pronoun> _objectPronouns = [
    Pronoun('me', 'me', DoerPronoun.I),
    Pronoun('you', 'te', DoerPronoun.you),
    Pronoun('him', 'lo/le', DoerPronoun.he),
    Pronoun('her', 'lo/le', DoerPronoun.she),
    Pronoun('it', 'lo/le', DoerPronoun.it),
    Pronoun('us', 'nos', DoerPronoun.we),
    Pronoun('them', 'les', DoerPronoun.they)
  ];
  static const List<Pronoun> _possessivePronouns = [
    Pronoun('mine', 'mio(a)/el mio/la mia/los míos/las mías', DoerPronoun.I),
    Pronoun(
        'yours',
        'tuyo/el tuyo/la tuya/los tuyos(as)/suyo/el suyo/la suya/las suyas',
        DoerPronoun.you),
    Pronoun('his', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.he),
    Pronoun(
        'hers', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.she),
    Pronoun('its', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.it),
    Pronoun('ours', 'nuestro/el nuestro/la nuestra/los nuestros/las nuestras',
        DoerPronoun.we),
    Pronoun(
        'theirs', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.they)
  ];
  static const List<Determiner> _articles = [
    Determiner.article('a', 'un/una', false, true, false),
    Determiner.article('an', 'un/una', false, true, false),
    Determiner.article('the', 'el/la/los/las', true, true, true),
  ];
  static const List<Determiner> _possessiveAdjectives = [
    Determiner.possessive('my', 'mi/mis'),
    Determiner.possessive('your', 'tu/tus/su/sus'),
    Determiner.possessive('his', 'su/sus'),
    Determiner.possessive('her', 'su/sus'),
    Determiner.possessive('its', 'su/sus'),
    Determiner.possessive('our', 'nuestro/nuestros'),
    Determiner.possessive('their', 'su/sus'),
  ];
  static const List<Determiner> _demonstrativeAdjectives = [
    Determiner.demonstrative('this', 'este/esta', true, true, false),
    Determiner.demonstrative('that', 'ese/esa', true, true, false),
    Determiner.demonstrative('these', 'estos/estas', false, false, true),
    Determiner.demonstrative('those', 'esos/esas', false, false, true),
  ];
  final List<Determiner> _distributiveAdjectives = [];
  final List<Determiner> _quantifiers = [];
  final List<Determiner> _ordinalNumbers = [];
  final List<Determiner> _naturalNumbers = [];
  final List<Adjective> _adjectives = [];
  final List<Noun> _nouns = [];
  final List<IndefinitePronoun> _indefinitePronouns = [];

  NounRepository(super.context) {
    _loadData();
  }

  List<Pronoun> subjectPronouns() => _subjectPronouns;

  List<Pronoun> objectPronouns() => _objectPronouns;

  List<Pronoun> possessivePronouns() => _possessivePronouns;

  List<Determiner> articles(Noun? noun) => noun == null
      ? _articles
      : noun.isPlural
          ? _articles.where((article) => article.en == 'the').toList()
          : Util.isVowel(Util.first(noun.en))
              ? _articles.where((article) => article.en != 'a').toList()
              : _articles.where((article) => article.en != 'an').toList();

  List<Determiner> possessiveAdjectives() => _possessiveAdjectives;

  List<Determiner> demonstrativeAdjectives(Noun? noun) => noun == null
      ? _demonstrativeAdjectives
      : _demonstrativeAdjectives
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> distributiveAdjectives(Noun? noun) => noun == null
      ? _distributiveAdjectives
      : _distributiveAdjectives
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> quantifiers(Noun? noun) => noun == null
      ? _quantifiers
      : _quantifiers
          .where((e) =>
              noun.isUncountable && e.isUncountableAllowed ||
              noun.isSingular && e.isSingularAllowed ||
              noun.isPlural && e.isPluralAllowed)
          .toList();

  List<Determiner> numbers(Noun? noun, [bool includeOrdinalNumbers = false]) =>
      noun == null
          ? [
              ..._naturalNumbers,
              if (includeOrdinalNumbers) ..._ordinalNumbers,
            ]
          : [
              ..._naturalNumbers
                  .where((e) =>
                      noun.isUncountable && e.isUncountableAllowed ||
                      noun.isSingular && e.isSingularAllowed ||
                      noun.isPlural && e.isPluralAllowed)
                  .toList(),
              if (includeOrdinalNumbers && !noun.isPlural) ..._ordinalNumbers,
            ];

  List<Adjective> adjectives() => _adjectives;

  List<Noun> nouns(Determiner? determiner) => determiner == null
      ? _nouns
      : _nouns.where((e) {
          return e.isUncountable && determiner.isUncountableAllowed ||
              e.isSingular && determiner.isSingularAllowed ||
              e.isPlural && determiner.isPluralAllowed;
        }).toList();

  List<IndefinitePronoun> indefinitePronouns(bool isNegative) => isNegative
      ? _indefinitePronouns.where((e) => e.isNegativeOnlyAllowed).toList()
      : _indefinitePronouns.where((e) => !e.isNegativeOnlyAllowed).toList();

  Future<void> _loadData() async {
    _distributiveAdjectives.addAll(await _getDistributiveAdjectives());
    _quantifiers.addAll(await _getQuantifiers());
    _ordinalNumbers.addAll(await _getOrdinalNumbers());
    _naturalNumbers.addAll(await _getNaturalNumbers());
    _adjectives.addAll(await _getAdjectives());
    _nouns.addAll(await _getNouns());
    _indefinitePronouns.addAll(await _getIndefinitePronouns());
    notifyListeners();
  }

  Future<List<Determiner>> _getDistributiveAdjectives() async {
    final rows = await getCsvData('determiners/distributive-adjectives');
    return rows
        .map(
          (row) => Determiner.distributiveAdjective(
              row.elementAt(0),
              row.elementAt(1),
              row.elementAt(2) == '1',
              row.elementAt(3) == '1',
              row.elementAt(4) == '1'),
        )
        .toList();
  }

  Future<List<Determiner>> _getQuantifiers() async {
    final rows = await getCsvData('determiners/quantifiers');
    return rows
        .map(
          (row) => Determiner.quantifier(
              row.elementAt(0),
              row.elementAt(1),
              row.elementAt(2) == '1',
              row.elementAt(3) == '1',
              row.elementAt(4) == '1'),
        )
        .toList();
  }

  Future<List<Determiner>> _getOrdinalNumbers() async {
    final rows = await getCsvData('determiners/ordinal-numbers');
    return rows
        .map((row) => Determiner.ordinalNumber(
              row.elementAt(0),
              row.elementAt(1),
            ))
        .toList();
  }

  Future<List<Determiner>> _getNaturalNumbers() async {
    final rows = await getCsvData('determiners/natural-numbers');
    return rows
        .map((row) => Determiner.naturalNumber(
              row.elementAt(0),
              row.elementAt(1),
            ))
        .toList();
  }

  Future<List<Adjective>> _getAdjectives() async {
    final rows = await getCsvData('adjectives');
    return rows
        .map((row) => Adjective(
              row.elementAt(0),
              row.elementAt(1),
              row.elementAt(2),
            ))
        .toList();
  }

  Future<List<IndefinitePronoun>> _getIndefinitePronouns() async {
    final rows = await getCsvData('nouns/indefinite-pronouns');
    return rows
        .map((row) => IndefinitePronoun(
            row.elementAt(0),
            row.elementAt(1),
            switch (row.elementAt(2)) {
              'singular' => Countability.singular,
              'plural' => Countability.plural,
              _ => Countability.uncountable,
            },
            switch (row.elementAt(3)) {
              'singular' => Countability.singular,
              'plural' => Countability.plural,
              _ => Countability.uncountable,
            },
            row.elementAt(4)))
        .toList();
  }

  Future<List<Noun>> _getNouns() async {
    final rows = await getCsvData('nouns/nouns');
    return rows
        .map((row) => Noun(
            row.elementAt(0),
            row.elementAt(1),
            switch (row.elementAt(2)) {
              'singular' => Countability.singular,
              'plural' => Countability.plural,
              _ => Countability.uncountable,
            }))
        .toList();
  }
}
