import 'any_adverb.dart';

class UndefinedAdverb extends AnyAdverb {
  final String label;
  const UndefinedAdverb(this.label);

  @override
  String toString() => label;
}
