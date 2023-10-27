import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class VocabularyProvider extends ChangeNotifier {
  final BuildContext context;

  VocabularyProvider(this.context);

  Future<List<List<dynamic>>> getCsvData(String filename) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "assets/vocabulary/$filename.csv",
    );
    return const CsvToListConverter()
        .convert(result, eol: "\n")
        .skip(1)
        .where((element) => element.length > 1)
        .toList();
  }
}
