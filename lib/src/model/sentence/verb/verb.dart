import '../../../util/util.dart';
import 'any_verb.dart';

class Verb extends AnyVerb {
  @override
  bool isTransitive;
  @override
  bool isDitransitive;
  @override
  bool isLinkingVerb;
  @override
  String infinitive;
  String past;
  @override
  String pastParticiple;

  Verb({
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
  });

  Verb.regular({
    required this.isTransitive,
    required this.isDitransitive,
    required this.infinitive,
    required this.past,
  }): pastParticiple = past, isLinkingVerb = false;

  @override
  String get presentParticiple => '${infinitive}ing';

  @override
  String present({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
    bool alternativeContraction = false,
  }) => singularThirdPerson? _presentForSingularThirdPerson : infinitive;

  @override
  String simplePast({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
  }) => past;

  String get _presentForSingularThirdPerson {
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
}
