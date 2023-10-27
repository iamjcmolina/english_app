import 'any_adjective.dart';

class Adjective extends AnyAdjective {
  final String en;
  final String singularEs;
  final String pluralEs;

  const Adjective(this.en, this.singularEs, this.pluralEs);

  @override
  String toString() => en;
}
