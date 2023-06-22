import 'subject.dart';

class EmptySubject implements Subject {
  @override
  bool get plural => false;

  @override
  bool get singular => true;

  @override
  bool get singularFirstPerson => true;

  @override
  bool get singularThirdPerson => false;

  @override
  String toString() => '<Subject>';
}
