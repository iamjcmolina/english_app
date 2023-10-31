import '../noun/subject_complement.dart';

abstract class AnyAdjective extends SubjectComplement {
  String get en;
  String get singularEs;
  String get pluralEs;
  String get es => '$singularEs/$pluralEs';

  const AnyAdjective();
}
