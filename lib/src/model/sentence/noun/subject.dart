import 'any_noun.dart';

abstract class Subject extends AnyNoun {
  bool get singular;
  bool get plural;
  bool get singularFirstPerson;
  bool get singularThirdPerson;
}
