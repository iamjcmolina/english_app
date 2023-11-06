import 'any_adjective.dart';

abstract class PhrasalAttributive extends AnyAdjective {
  String get es;

  const PhrasalAttributive();

  @override
  String toEs([bool? isPluralSubject]) => es;
}
