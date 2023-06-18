import '../../util/util.dart';
import '../noun/subject.dart';
import 'verb.dart';

class VerbWord extends Verb {
  static String simplePresentForSingularThirdPerson(String infinitive) {
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
  String simplePast;
  @override
  String pastParticiple;

  VerbWord({
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
    required this.infinitive,
    required this.simplePast,
    required this.pastParticiple,
  });

  VerbWord.regular({
    required this.isTransitive,
    required this.isDitransitive,
    required this.infinitive,
    required this.simplePast,
  }): pastParticiple = simplePast, isLinkingVerb = false;

  @override
  bool get isBe => infinitive == 'be';

  @override
  String get progressive => '${infinitive}ing';

  @override
  String simplePresent(Subject subject) {
    if (subject.singularThirdPerson) {
      return VerbWord.simplePresentForSingularThirdPerson(infinitive);
    }
    return infinitive;
  }
}
