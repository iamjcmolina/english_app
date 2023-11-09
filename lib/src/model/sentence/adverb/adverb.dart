import 'adverb_type.dart';
import 'any_adverb.dart';
import 'kind_of_degree.dart';

class Adverb extends AnyAdverb {
  static const List<Adverb> frequencyAdverbs = [
    Adverb.frequency('always', 'siempre', '', false),
    Adverb.frequency('usually', 'usualmente', ''),
    Adverb.frequency('generally', 'generalmente', ''),
    Adverb.frequency('often', 'frecuentemente', ''),
    Adverb.frequency('sometimes', 'algunas veces', ''),
    Adverb.frequency('occasionally', 'ocasionalmente', ''),
    Adverb.frequency('seldom', 'rara vez', ''),
    Adverb.frequency('rarely', 'casi nunca', ''),
    Adverb.frequency('never', 'nunca', '', false),
  ];
  @override
  final String en;
  @override
  final String es;
  final AdverbType type;
  @override
  final bool isAllowedInFront;
  @override
  final bool isAllowedInTheMiddle;
  @override
  final bool isAllowedInTheEnd;
  final KindOfDegree kindOfDegree;
  final String help;

  @override
  bool get isValid => true;

  const Adverb({
    required this.en,
    required this.es,
    required this.type,
    required this.isAllowedInFront,
    required this.isAllowedInTheMiddle,
    required this.isAllowedInTheEnd,
    this.kindOfDegree = KindOfDegree.none,
    this.help = '',
  });

  const Adverb.frequency(String en, String es, String help,
      [bool isAllowedInFront = true,
      bool isAllowedInTheMiddle = true,
      bool isAllowedInTheEnd = true])
      : this(
          en: en,
          es: es,
          type: AdverbType.frequency,
          isAllowedInFront: isAllowedInFront,
          isAllowedInTheMiddle: isAllowedInTheMiddle,
          isAllowedInTheEnd: isAllowedInTheEnd,
          help: help,
        );

  const Adverb.certainty(String en, String es, bool isAllowedInFront,
      bool isAllowedInTheMiddle, bool isAllowedInTheEnd, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.certainty,
          isAllowedInFront: isAllowedInFront,
          isAllowedInTheMiddle: isAllowedInTheMiddle,
          isAllowedInTheEnd: isAllowedInTheEnd,
          help: help,
        );

  const Adverb.degree(
      String en, String es, KindOfDegree kindOfDegree, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.degree,
          isAllowedInFront: false,
          isAllowedInTheMiddle: false,
          isAllowedInTheEnd: false,
          kindOfDegree: kindOfDegree,
          help: help,
        );

  const Adverb.duration(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.duration,
          isAllowedInFront: false,
          isAllowedInTheMiddle: false,
          isAllowedInTheEnd: true,
          help: help,
        );

  const Adverb.evaluative(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.evaluative,
          isAllowedInFront: true,
          isAllowedInTheMiddle: true,
          isAllowedInTheEnd: true,
          help: help,
        );

  const Adverb.focusing(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.focusing,
          isAllowedInFront: false,
          isAllowedInTheMiddle: true,
          isAllowedInTheEnd: false,
          help: help,
        );

  const Adverb.manner(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.manner,
          isAllowedInFront: false,
          isAllowedInTheMiddle: true,
          isAllowedInTheEnd: true,
          help: help,
        );

  const Adverb.place(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.place,
          isAllowedInFront: true,
          isAllowedInTheMiddle: false,
          isAllowedInTheEnd: true,
          help: help,
        );

  const Adverb.time(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.time,
          isAllowedInFront: true,
          isAllowedInTheMiddle: false,
          isAllowedInTheEnd: true,
          help: help,
        );

  const Adverb.viewpoint(String en, String es, String help)
      : this(
          en: en,
          es: es,
          type: AdverbType.viewpoint,
          isAllowedInFront: true,
          isAllowedInTheMiddle: true,
          isAllowedInTheEnd: false,
          help: help,
        );
}
