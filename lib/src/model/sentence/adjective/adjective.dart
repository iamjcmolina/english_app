import 'any_adjective.dart';

class Adjective extends AnyAdjective {
  final String value;
  final String singularEs;
  final String pluralEs;

  const Adjective(this.value, this.singularEs, this.pluralEs);

  @override
  String toString() => value;
}
