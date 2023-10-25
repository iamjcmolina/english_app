import 'any_adverb.dart';
import 'value/adverb_position.dart';
import 'value/adverb_type.dart';

class Adverb extends AnyAdverb {
  @override
  final String en;
  @override
  final String es;
  final AdverbType type;
  final Set<AdverbPosition> positions;

  Adverb(this.en, this.es, this.type, this.positions);

  Adverb.manner(String value, String es)
      : this(
          value,
          es,
          AdverbType.manner,
          {AdverbPosition.end, AdverbPosition.mid},
        );

  Adverb.place(String value, String es)
      : this(
          value,
          es,
          AdverbType.place,
          {AdverbPosition.end, AdverbPosition.front},
        );

  Adverb.time(String value, String es)
      : this(
          value,
          es,
          AdverbType.time,
          {AdverbPosition.end, AdverbPosition.front},
        );

  Adverb.duration(String value, String es)
      : this(
          value,
          es,
          AdverbType.duration,
          {AdverbPosition.end},
        );

  Adverb.frequency(String value, String es,
      [Set<AdverbPosition> positions = const {
        AdverbPosition.mid,
        AdverbPosition.front,
        AdverbPosition.end
      }])
      : this(
          value,
          es,
          AdverbType.frequency,
          positions,
        );

  Adverb.degree(String value, String es, Set<AdverbPosition> positions)
      : this(
          value,
          es,
          AdverbType.degree,
          positions,
        );

  Adverb.focusing(String value, String es)
      : this(
          value,
          es,
          AdverbType.focusing,
          {AdverbPosition.mid},
        );

  Adverb.certainty(String value, String es, Set<AdverbPosition> positions)
      : this(
          value,
          es,
          AdverbType.certainty,
          positions,
        );

  Adverb.viewpoint(String value, String es)
      : this(
          value,
          es,
          AdverbType.viewpoint,
          {AdverbPosition.front, AdverbPosition.mid},
        );

  Adverb.evaluative(String value, String es)
      : this(
          value,
          es,
          AdverbType.evaluative,
          {AdverbPosition.front, AdverbPosition.mid, AdverbPosition.end},
        );

  @override
  String toString() => en;
}
