import '../../../util/util.dart';
import 'any_verb.dart';

class Verb extends AnyVerb {
  @override
  final String infinitive;
  final String past;
  @override
  final String pastParticiple;
  @override
  final String infinitiveEs;
  @override
  final String pastParticipleEs;
  @override
  final String progressiveEs;
  @override
  final String presentHeEs;
  @override
  final String pastIEs;
  @override
  final String pastWeEs;
  @override
  final bool isTransitive;
  @override
  final bool isDitransitive;
  @override
  final bool isLinkingVerb;

  const Verb({
    required this.infinitive,
    required this.past,
    required this.pastParticiple,
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentHeEs,
    required this.pastIEs,
    required this.pastWeEs,
    required this.isTransitive,
    required this.isDitransitive,
    this.isLinkingVerb = false,
  });

  @override
  String get progressive => '${infinitive}ing';
  @override
  String get presentIEs => '${Util.removeLast(presentHeEs)}o';
  @override
  String get presentSingularYouEs => '${presentHeEs}s';
  @override
  String get presentWeEs => '${Util.removeLast(infinitiveEs)}mos';
  @override
  String get presentTheyEs => '${presentHeEs}n';
  @override
  String get pastSingularYouEs => '${Util.removeLast(pastWeEs, 3)}ste';
  @override
  String get pastHeEs => '$_progressiveEsLess4ó';

  @override
  String get pastTheyEs => switch (Util.last(progressiveEs, 4)) {
        'ando' => '${_progressiveEsLess4}aron',
        _ => '${_progressiveEsLess4}eron',
      };

  @override
  String get futureIEs => '$infinitiveEsé';
  @override
  String get futureSingularYouEs => '$infinitiveEsás';
  @override
  String get futureHeEs => '$infinitiveEsá';
  @override
  String get futureWeEs => '${infinitiveEs}emos';
  @override
  String get futureTheyEs => '$infinitiveEsán';
  @override
  String get conditionalIEs => '$infinitiveEsía';
  @override
  String get conditionalSingularYouEs => '$infinitiveEsías';
  @override
  String get conditionalHeEs => '$infinitiveEsía';
  @override
  String get conditionalWeEs => '$infinitiveEsíamos';
  @override
  String get conditionalTheyEs => '$infinitiveEsían';
  String get _progressiveEsLess4 => Util.removeLast(progressiveEs, 4);
}
