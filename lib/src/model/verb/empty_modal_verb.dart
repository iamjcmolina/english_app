import 'modal_verb.dart';

class EmptyModalVerb implements ModalVerb {
  @override
  String value = '<Modal Verb>';

  @override
  String negative([bool enableContraction = true]) => '<Negative Modal Verb>';
}
