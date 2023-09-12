import 'any_verb.dart';

class Be extends AnyVerb {
  @override
  bool get isLinkingVerb => true;

  @override
  bool get isTransitive => false;

  @override
  bool get isDitransitive => false;

  @override
  String get infinitive => 'be';

  @override
  String get presentParticiple => 'being';

  @override
  String get pastParticiple => 'been';

  @override
  String present({
    required bool singularFirstPerson,
    required bool singularThirdPerson,
    required bool contraction,
    required bool negativeContraction,
    required bool negative,
  }) {
    if (negative) {
      if (singularFirstPerson) {
        return contraction? "'m not" : 'am not';
      } else if (singularThirdPerson) {
        return negativeContraction? "isn't" : contraction? "'s not" : 'is not';
      }
      return negativeContraction? "aren't" : contraction? "'re not" : 'are not';
    }
    if (singularFirstPerson) {
      return contraction? "'m" : 'am';
    } else if (singularThirdPerson) {
      return contraction? "'s" : 'is';
    }
    return contraction? "'re" : 'are';
  }

  @override
  String simplePast({
    required bool singular,
    required bool negativeContraction,
    required bool negative,
  }) {
    if (negative) {
      return negativeContraction
          ? singular ? "wasn't" : "weren't"
          : singular ? 'was not' : 'were not';
    }
    return singular ? 'was' : 'were';
  }
}
