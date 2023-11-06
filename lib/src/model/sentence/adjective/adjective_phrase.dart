import 'any_adjective.dart';

abstract class AdjectivePhrase extends AnyAdjective {
  String get singularEs;
  String get pluralEs;

  const AdjectivePhrase();

  @override
  String toEs([bool? isPluralSubject]) => isPluralSubject == null
      ? '$singularEs/$pluralEs'
      : isPluralSubject
          ? pluralEs
          : singularEs;
}
