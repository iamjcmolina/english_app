import 'any_verb.dart';

class Be extends AnyVerb {
  static const ser = Be(
      infinitiveEs: 'ser',
      pastParticipleEs: 'sido',
      progressiveEs: 'siendo',
      presentIEs: 'soy',
      presentSingularYouEs: 'eres',
      presentHeEs: 'es',
      presentWeEs: 'somos',
      presentTheyEs: 'son',
      pastIEs: 'fuí',
      pastSingularYouEs: 'fuiste',
      pastHeEs: 'fué',
      pastWeEs: 'fuimos',
      pastTheyEs: 'fueron',
      futureIEs: 'seré',
      futureSingularYouEs: 'serás',
      futureHeEs: 'será',
      futureWeEs: 'seremos',
      futureTheyEs: 'serán',
      conditionalIEs: 'sería',
      conditionalSingularYouEs: 'serías',
      conditionalHeEs: 'sería',
      conditionalWeEs: 'seríamos',
      conditionalTheyEs: 'serían');
  static const estar = Be(
      infinitiveEs: 'estar',
      pastParticipleEs: 'estado',
      progressiveEs: 'estando',
      presentIEs: 'estoy',
      presentSingularYouEs: 'estas',
      presentHeEs: 'está',
      presentWeEs: 'estamos',
      presentTheyEs: 'están',
      pastIEs: 'estuve',
      pastSingularYouEs: 'estuviste',
      pastHeEs: 'estuvo',
      pastWeEs: 'estuvimos',
      pastTheyEs: 'estuvieron',
      futureIEs: 'estaré',
      futureSingularYouEs: 'estarás',
      futureHeEs: 'estará',
      futureWeEs: 'estaremos',
      futureTheyEs: 'estarán',
      conditionalIEs: 'estaría',
      conditionalSingularYouEs: 'estarías',
      conditionalHeEs: 'estaría',
      conditionalWeEs: 'estaremos',
      conditionalTheyEs: 'estarían');
  @override
  final String infinitive = 'be';
  @override
  final String pastParticiple = 'been';
  @override
  final String progressive = 'being';
  @override
  final String infinitiveEs;
  @override
  final String pastParticipleEs;
  @override
  final String progressiveEs;
  @override
  final String presentIEs;
  @override
  final String presentSingularYouEs;
  @override
  final String presentHeEs;
  @override
  final String presentWeEs;
  @override
  final String presentTheyEs;
  @override
  final String pastIEs;
  @override
  final String pastSingularYouEs;
  @override
  final String pastHeEs;
  @override
  final String pastWeEs;
  @override
  final String pastTheyEs;
  @override
  final String futureIEs;
  @override
  final String futureSingularYouEs;
  @override
  final String futureHeEs;
  @override
  final String futureWeEs;
  @override
  final String futureTheyEs;
  @override
  final String conditionalIEs;
  @override
  final String conditionalSingularYouEs;
  @override
  final String conditionalHeEs;
  @override
  final String conditionalWeEs;
  @override
  final String conditionalTheyEs;
  @override
  final bool isTransitive = false;
  @override
  final bool isDitransitive = false;
  @override
  final bool isLinkingVerb = true;

  const Be({
    required this.infinitiveEs,
    required this.pastParticipleEs,
    required this.progressiveEs,
    required this.presentIEs,
    required this.presentSingularYouEs,
    required this.presentHeEs,
    required this.presentWeEs,
    required this.presentTheyEs,
    required this.pastIEs,
    required this.pastSingularYouEs,
    required this.pastHeEs,
    required this.pastWeEs,
    required this.pastTheyEs,
    required this.futureIEs,
    required this.futureSingularYouEs,
    required this.futureHeEs,
    required this.futureWeEs,
    required this.futureTheyEs,
    required this.conditionalIEs,
    required this.conditionalSingularYouEs,
    required this.conditionalHeEs,
    required this.conditionalWeEs,
    required this.conditionalTheyEs,
  });
}
