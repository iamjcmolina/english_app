import 'adverb.dart';
import 'adverb_type.dart';

class AdverbWord  extends Adverb {
  AdverbType type;
  String adverb;

  AdverbWord({
    required this.type,
    required this.adverb,
  });

  @override
  AdverbType get adverbType => type;
}
