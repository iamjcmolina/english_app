import '../noun/subject.dart';

abstract class Verb {
  static String simplePresentBe(Subject subject, [bool enableContraction = true]) {
    if (subject.singularFirstPerson) {
      return enableContraction? "'m" : 'am';
    } else if (subject.singularThirdPerson) {
      return enableContraction? "'s" : 'is';
    }
    return enableContraction? "'re" : 'are';
  }

  static String negativeSimplePresentBe(Subject subject, [bool enableContraction = true, bool enableSecondContraction = false]) {
    if (subject.singularFirstPerson) {
      return enableContraction? "'m not" : 'am';
    } else if (subject.singularThirdPerson) {
      return enableSecondContraction? "isn't" : enableContraction? "'s not" : 'is';
    }
    return enableSecondContraction? "aren't" : enableContraction? "'re not" : 'are';
  }

  static String simplePastBe(Subject subject) =>
      (subject.singularFirstPerson || subject.singularThirdPerson) ? 'was' : 'were';

  static String negativeSimplePastBe(Subject subject, [bool enableContraction = true]) {
    return enableContraction? (subject.singularFirstPerson || subject.singularThirdPerson) ? "wasn't" : "weren't"
        :(subject.singularFirstPerson || subject.singularThirdPerson) ? 'was not' : 'were not';
  }

  bool get isTransitive; // A transitive verb can have a direct object, if false, it's intransitive
  bool get isDitransitive; // A ditransitive verb can have direct and indirect objects
  bool get isLinkingVerb;
  bool get isBe;
  String get progressive;
  String get infinitive;
  String get simplePast;
  String get pastParticiple;
  String simplePresent(Subject subject);
}
