import 'adjective.dart';

class AdverbAndAdjective implements Adjective {
  final String adverb; // intensifier/mitigator
  final String adjective;

  AdverbAndAdjective({required this.adverb,required this.adjective});

  // AdverbAndAdjective copyWith() => AdverbAndAdjective();

  @override
  String toString() => '$adverb $adjective';
}
