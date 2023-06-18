import 'preposition_type.dart';

class Preposition {
  String value;
  PrepositionType type;

  Preposition({required this.value, required this.type});

  @override
  String toString() {
    return value;
  }
}
