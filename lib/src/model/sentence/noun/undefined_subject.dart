import 'subject.dart';

class UndefinedSubject extends Subject {
  @override
  bool get plural => false;

  @override
  bool get singular => true;

  @override
  bool get singularFirstPerson => true;

  @override
  bool get singularThirdPerson => false;
}
