import '../model/sentence/adverb/adverb.dart';
import 'vocabulary_provider.dart';

class AdverbRepository extends VocabularyProvider {
  final List<Adverb> _mannerAdverbs = [];
  final List<Adverb> _placeAdverbs = [];
  final List<Adverb> _timeAdverbs = [];
  final List<Adverb> _durationAdverbs = [];
  final List<Adverb> _degreeAdverbs = [];
  final List<Adverb> _focusingAdverbs = [];
  final List<Adverb> _certaintyAdverbs = [];
  final List<Adverb> _viewpointAdverbs = [];
  final List<Adverb> _evaluativeAdverbs = [];

  AdverbRepository(super.context) {
    _loadData();
  }

  List<Adverb> adverbs() => [
        ..._certaintyAdverbs,
        ..._degreeAdverbs,
        ..._durationAdverbs,
        ..._evaluativeAdverbs,
        ..._focusingAdverbs,
        ..._mannerAdverbs,
        ..._placeAdverbs,
        ..._timeAdverbs,
        ..._viewpointAdverbs,
      ];

  List<Adverb> frontAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInFront).toList();

  List<Adverb> midAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInTheMiddle).toList();

  List<Adverb> endAdverbs() =>
      adverbs().where((adverb) => adverb.isAllowedInTheEnd).toList();

  Future<void> _loadData() async {
    _mannerAdverbs.addAll(await _getMannerAdverbs());
    _placeAdverbs.addAll(await _getPlaceAdverbs());
    _timeAdverbs.addAll(await _getTimeAdverbs());
    _durationAdverbs.addAll(await _getDurationAdverbs());
    _degreeAdverbs.addAll(await _getDegreeAdverbs());
    _focusingAdverbs.addAll(await _getFocusingAdverbs());
    _certaintyAdverbs.addAll(await _getCertaintyAdverbs());
    _viewpointAdverbs.addAll(await _getViewpointAdverbs());
    _evaluativeAdverbs.addAll(await _getEvaluativeAdverbs());
    notifyListeners();
  }

  Future<List<Adverb>> _getMannerAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/manner');
    return rows
        .map((row) => Adverb.manner(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getPlaceAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/place');
    return rows
        .map((row) => Adverb.place(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getTimeAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/time');
    return rows
        .map((row) => Adverb.time(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getDurationAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/duration');
    return rows
        .map((row) => Adverb.duration(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getDegreeAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/degree');
    return rows
        .map((row) => Adverb.degree(
            row.elementAt(0),
            row.elementAt(1),
            row.elementAt(2) == '1',
            row.elementAt(3) == '1',
            row.elementAt(4) == '1'))
        .toList();
  }

  Future<List<Adverb>> _getFocusingAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/focusing');
    return rows
        .map((row) => Adverb.focusing(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getCertaintyAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/certainty');
    return rows
        .map((row) => Adverb.certainty(
            row.elementAt(0),
            row.elementAt(1),
            row.elementAt(2) == '1',
            row.elementAt(3) == '1',
            row.elementAt(4) == '1'))
        .toList();
  }

  Future<List<Adverb>> _getViewpointAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/viewpoint');
    return rows
        .map((row) => Adverb.viewpoint(row.elementAt(0), row.elementAt(1)))
        .toList();
  }

  Future<List<Adverb>> _getEvaluativeAdverbs() async {
    List<List<dynamic>> rows = await getCsvData('adverbs/evaluative');
    return rows
        .map((row) => Adverb.evaluative(row.elementAt(0), row.elementAt(1)))
        .toList();
  }
}
