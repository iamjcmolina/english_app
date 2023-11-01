import 'adverb_type.dart';
import 'any_adverb.dart';

class Adverb extends AnyAdverb {
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

  @override
  bool get isValid => true;

  const Adverb(this.en, this.es, this.type, this.isAllowedInFront,
      this.isAllowedInTheMiddle, this.isAllowedInTheEnd);

  const Adverb.manner(String en, String es)
      : this(en, es, AdverbType.manner, false, true, true);

  const Adverb.place(String en, String es)
      : this(en, es, AdverbType.place, true, false, true);

  const Adverb.time(String en, String es)
      : this(en, es, AdverbType.time, true, false, true);

  const Adverb.duration(String en, String es)
      : this(en, es, AdverbType.duration, false, false, true);

  const Adverb.frequency(String en, String es,
      [bool isAllowedInFront = true,
      bool isAllowedInTheMiddle = true,
      bool isAllowedInTheEnd = true])
      : this(en, es, AdverbType.frequency, isAllowedInFront,
            isAllowedInTheMiddle, isAllowedInTheEnd);

  const Adverb.degree(String en, String es, bool isAllowedInFront,
      bool isAllowedInTheMiddle, bool isAllowedInTheEnd)
      : this(en, es, AdverbType.degree, isAllowedInFront, isAllowedInTheMiddle,
            isAllowedInTheEnd);

  const Adverb.focusing(String en, String es)
      : this(en, es, AdverbType.focusing, false, true, false);

  const Adverb.certainty(String en, String es, bool isAllowedInFront,
      bool isAllowedInTheMiddle, bool isAllowedInTheEnd)
      : this(en, es, AdverbType.certainty, isAllowedInFront,
            isAllowedInTheMiddle, isAllowedInTheEnd);

  const Adverb.viewpoint(String en, String es)
      : this(en, es, AdverbType.viewpoint, true, true, false);

  const Adverb.evaluative(String en, String es)
      : this(en, es, AdverbType.evaluative, true, true, true);

  @override
  String toString() => en;
}
