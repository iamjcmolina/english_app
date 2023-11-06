import 'adjective_phrase.dart';

class Adjective extends AdjectivePhrase {
  @override
  final bool isValid = true;
  @override
  final String en;
  @override
  final String singularEs;
  @override
  final String pluralEs;

  const Adjective(this.en, this.singularEs, this.pluralEs);
}
