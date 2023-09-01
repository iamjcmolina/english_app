import 'adverb_phrase.dart';
import 'adverb_type.dart';
import 'adverb_word.dart';

class AdverbAndAdverb extends AdverbPhrase {
  AdverbWord intensifierOrMitigatorAdverb;
  AdverbWord adverb;

  AdverbAndAdverb({
    required this.intensifierOrMitigatorAdverb,
    required this.adverb,
  });

  @override
  // TODO: implement adverbType, it can be: manner, time
  AdverbType get adverbType => throw UnimplementedError();
}
