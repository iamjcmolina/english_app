import '../model/sentence/phrase/preposition.dart';
import 'vocabulary_provider.dart';

class CommonRepository extends VocabularyProvider {
  final List<Preposition> _prepositions = [];

  CommonRepository(super.context) {
    _loadData();
  }

  List<Preposition> prepositions() => _prepositions;

  Future<void> _loadData() async {
    _prepositions.addAll(await _getPrepositions());
    notifyListeners();
  }

  Future<List<Preposition>> _getPrepositions() async {
    final rows = await getCsvData('prepositions');
    return rows
        .map(
          (row) => Preposition(
            en: row.elementAt(0),
            es: row.elementAt(1),
          ),
        )
        .toList();
  }
}
