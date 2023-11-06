import 'any_adjective.dart';

class Adjective implements AnyAdjective {
  @override
  final bool isValid = true;
  @override
  final String en;
  final String singularEs;
  final String pluralEs;

  const Adjective(this.en, this.singularEs, this.pluralEs);

  @override
  String toEs([bool? isPluralSubject]) => isPluralSubject == null
      ? '$singularEs/$pluralEs'
      : isPluralSubject
          ? pluralEs
          : singularEs;
}
