import '../noun/subject_complement.dart';

abstract class AnyAdjective extends SubjectComplement {
  static const adjectivePlaceholder = '<Adjective>';
  static const adjectiveComplementPlaceholder = '<AdjectiveComplement>';
  static const adjectivePlaceholderEs = '<Adjetivo>';
  static const adjectiveComplementPlaceholderEs = '<ComplementoDelAdjetivo>';
  @override
  final bool isValid = true;
  @override
  String get en;
  String get singularEs;
  String get pluralEs;
  @override
  String get es => '$singularEs/$pluralEs';

  const AnyAdjective();
}
