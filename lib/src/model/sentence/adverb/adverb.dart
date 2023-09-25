import 'any_adverb.dart';
import 'value/adverb_position.dart';
import 'value/adverb_type.dart';

class Adverb extends AnyAdverb {
  final String value;
  final AdverbType type;
  final Set<AdverbPosition> positions;

  Adverb(this.value, this.type, this.positions);

  Adverb.manner(String value): this(
    value,
    AdverbType.manner,
    {AdverbPosition.end, AdverbPosition.mid},
  );

  Adverb.place(String value): this(
    value,
    AdverbType.place,
    {AdverbPosition.end, AdverbPosition.front},
  );

  Adverb.time(String value): this(
    value,
    AdverbType.time,
    {AdverbPosition.end, AdverbPosition.front},
  );

  Adverb.duration(String value): this(
    value,
    AdverbType.duration,
    {AdverbPosition.end},
  );

  Adverb.frequency(String value,
      [Set<AdverbPosition> positions =
      const {AdverbPosition.mid, AdverbPosition.front, AdverbPosition.end}])
      : this(
    value,
    AdverbType.frequency,
    positions,
  );

  Adverb.degree(String value, Set<AdverbPosition> positions): this(
    value,
    AdverbType.degree,
    positions,
  );

  Adverb.focusing(String value): this(
    value,
    AdverbType.focusing,
    {AdverbPosition.mid},
  );

  Adverb.certainty(String value, Set<AdverbPosition> positions): this(
    value,
    AdverbType.certainty,
    positions,
  );

  Adverb.viewpoint(String value): this(
    value,
    AdverbType.viewpoint,
    {AdverbPosition.front, AdverbPosition.mid},
  );

  Adverb.evaluative(String value): this(
    value,
    AdverbType.evaluative,
    {AdverbPosition.front, AdverbPosition.mid, AdverbPosition.end},
  );

  @override
  String toString() => value;
}
