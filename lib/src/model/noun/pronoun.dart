import 'subject.dart';

class Pronoun extends Subject {
  String value;

  Pronoun(this.value);

  @override
  bool get singularFirstPerson => value.toLowerCase() == 'i';

  @override
  bool get singularThirdPerson => ['he','she','it'].contains(value.toLowerCase());

  @override
  bool get singular => ['i','you','he','she','it'].contains(value.toLowerCase());

  @override
  // TODO: implement plural
  bool get plural => ['you','we','they'].contains(value.toLowerCase());

  @override
  String toString() => value;
}
