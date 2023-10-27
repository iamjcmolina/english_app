import '../model/sentence/verb/any_verb.dart';
import '../model/sentence/verb/be.dart';
import '../model/sentence/verb/modal_verb.dart';
import '../model/sentence/verb/verb.dart';
import 'vocabulary_provider.dart';

class VerbRepository extends VocabularyProvider {
  static const List<ModalVerb> _modalVerbs = [
    ModalVerb(
        verb: 'can',
        verbContraction: "can",
        negative: 'cannot',
        negativeContraction: "can't",
        affirmativeIEs: 'puedo',
        affirmativeSingularYouEs: 'puedes',
        affirmativeHeEs: 'puede',
        affirmativeWeEs: 'podemos',
        affirmativeTheyEs: 'pueden'),
    ModalVerb(
        verb: 'could',
        verbContraction: "could",
        negative: 'could not',
        negativeContraction: "couldn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'may',
        verbContraction: "may",
        negative: 'may not',
        negativeContraction: "mayn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'might',
        verbContraction: "might",
        negative: 'might not',
        negativeContraction: "mightn't",
        affirmativeIEs: 'podría',
        affirmativeSingularYouEs: 'podrías',
        affirmativeHeEs: 'podría',
        affirmativeWeEs: 'podríamos',
        affirmativeTheyEs: 'podrían'),
    ModalVerb(
        verb: 'must',
        verbContraction: "must",
        negative: 'must not',
        negativeContraction: "mustn't",
        affirmativeIEs: 'debo',
        affirmativeSingularYouEs: 'debes',
        affirmativeHeEs: 'debe',
        affirmativeWeEs: 'debemos',
        affirmativeTheyEs: 'deben'),
    ModalVerb(
        verb: 'should',
        verbContraction: "should",
        negative: 'should not',
        negativeContraction: "shouldn't",
        affirmativeIEs: 'debería',
        affirmativeSingularYouEs: 'deberías',
        affirmativeHeEs: 'debería',
        affirmativeWeEs: 'deberíamos',
        affirmativeTheyEs: 'deberían'),
    ModalVerb(
        verb: 'would',
        verbContraction: "'d",
        negative: 'would not',
        negativeContraction: "wouldn't",
        affirmativeIEs: '',
        affirmativeSingularYouEs: '',
        affirmativeHeEs: '',
        affirmativeWeEs: '',
        affirmativeTheyEs: ''),
  ];
  static const Be _be = Be(
      infinitiveEs: 'ser',
      pastParticipleEs: 'sido',
      progressiveEs: 'siendo',
      presentIEs: 'soy',
      presentSingularYouEs: 'eres',
      presentHeEs: 'es',
      presentWeEs: 'somos',
      presentTheyEs: 'son',
      pastIEs: 'fuí',
      pastSingularYouEs: 'fuiste',
      pastHeEs: 'fué',
      pastWeEs: 'fuimos',
      pastTheyEs: 'fueron',
      futureIEs: 'seré',
      futureSingularYouEs: 'serás',
      futureHeEs: 'será',
      futureWeEs: 'seremos',
      futureTheyEs: 'serán',
      conditionalIEs: 'sería',
      conditionalSingularYouEs: 'serías',
      conditionalHeEs: 'sería',
      conditionalWeEs: 'seríamos',
      conditionalTheyEs: 'serían');
  final List<AnyVerb> _verbs = [];

  VerbRepository(super.context) {
    _loadData();
  }

  List<ModalVerb> modalVerbs() => _modalVerbs;

  List<AnyVerb> verbs() => [_be, ..._verbs];

  Future<void> _loadData() async {
    _verbs.addAll([_be, ...await _getVerbs()]);
    notifyListeners();
  }

  Future<List<Verb>> _getVerbs() async {
    final rows = await getCsvData('verbs');
    return rows
        .map((row) => Verb(
              infinitive: row.elementAt(0),
              past: row.elementAt(1),
              pastParticiple: row.elementAt(2),
              infinitiveEs: row.elementAt(3),
              pastParticipleEs: row.elementAt(4),
              progressiveEs: row.elementAt(5),
              presentHeEs: row.elementAt(6),
              pastIEs: row.elementAt(7),
              pastWeEs: row.elementAt(8),
              isTransitive: row.elementAt(9) == '1',
              isDitransitive: row.elementAt(10) == '1',
              isLinkingVerb: row.elementAt(11) == '1',
            ))
        .toList();
  }
}
