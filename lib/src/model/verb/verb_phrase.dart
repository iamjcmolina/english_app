import 'phrasal_verb_particle.dart';

class VerbPhrase {
  bool isFirstVerbContracted;
  bool invertAuxiliarAndSubject;
  List<String?> auxiliars;
  String conjugatedVerbWord;

  VerbPhrase({
    this.isFirstVerbContracted = false,
    this.invertAuxiliarAndSubject = false,
    required this.auxiliars,
    required this.conjugatedVerbWord,
  });

  String? get firstAuxiliar =>
      auxiliars.isEmpty? null : auxiliars.first;

  String? get secondAuxiliar =>
      auxiliars.isEmpty || auxiliars.length == 1? null : auxiliars.elementAt(1);

  String? get thirdAuxiliar =>
      auxiliars.isEmpty || auxiliars.length == 2? null : auxiliars.elementAt(2);
}
