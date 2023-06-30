import '../../util/util.dart';
import '../noun/subject.dart';
import 'verb.dart';

class VerbWord extends Verb {
  static String presentForSingularThirdPerson(String infinitive) {
    String penultimateLetter =
        infinitive.substring(infinitive.length - 2, infinitive.length - 1);
    String lastLetter = infinitive.substring(infinitive.length - 1);
    String lastTwoLetters = infinitive.substring(infinitive.length - 2);
    if (lastLetter == 'o' ||
        lastTwoLetters == 'sh' ||
        lastTwoLetters == 'ch' ||
        lastTwoLetters == 'ss' ||
        lastLetter == 'x' ||
        lastLetter == 'z') {
      return '${infinitive}es';
    } else if (lastLetter == 'y' && Util.isConsonant(penultimateLetter)) {
      String newWord = infinitive.substring(0, infinitive.length - 1);
      return '${newWord}ies';
    }
    return '${infinitive}s';
  }

  @override
  bool isTransitive;
  @override
  bool isDitransitive;
  @override
  bool isLinkingVerb;
  @override
  String infinitive;
  @override
  String past;
  @override
  String pastParticiple;

  VerbWord({
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
  });

  VerbWord.regular({
    required this.isTransitive,
    required this.isDitransitive,
    required this.infinitive,
    required this.past,
  }): pastParticiple = past, isLinkingVerb = false;

  @override
  bool get isBe => infinitive == 'be';

  @override
  String get presentParticiple => '${infinitive}ing';

  @override
  String present(Subject subject, [bool enableContraction = true, bool negative = false, bool alternativeContraction = false]) {
    if(isBe) {
      if (negative) {
        return Verb.negativeSimplePresentBe(subject, enableContraction, alternativeContraction);
      }
      return Verb.simplePresentBe(subject, enableContraction);
    }
    if (subject.singularThirdPerson) {
      return VerbWord.presentForSingularThirdPerson(infinitive);
    }
    return infinitive;
  }
}
