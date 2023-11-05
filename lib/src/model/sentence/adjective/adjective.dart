import 'any_adjective.dart';

class Adjective extends AnyAdjective {
  @override
  final String en;
  @override
  final String singularEs;
  @override
  final String pluralEs;

  const Adjective(this.en, this.singularEs, this.pluralEs);
}
