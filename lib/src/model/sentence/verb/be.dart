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
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
    bool alternativeContraction = false,
  }) {
    if (negative) {
      if (singularFirstPerson) {
        return enableContraction? "'m not" : 'am not';
      } else if (singularThirdPerson) {
        return alternativeContraction? "isn't" : enableContraction? "'s not" : 'is';
      }
      return alternativeContraction? "aren't" : enableContraction? "'re not" : 'are';
    }
    if (singularFirstPerson) {
      return enableContraction? "'m" : 'am';
    } else if (singularThirdPerson) {
      return enableContraction? "'s" : 'is';
    }
    return enableContraction? "'re" : 'are';
  }

  @override
  String simplePast({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
  }) {
    if (negative) {
      return enableContraction? (singularFirstPerson || singularThirdPerson) ? "wasn't" : "weren't"
          :(singularFirstPerson || singularThirdPerson) ? 'was not' : 'were not';
    }
    return (singularFirstPerson || singularThirdPerson) ? 'was' : 'were';
  }
}
