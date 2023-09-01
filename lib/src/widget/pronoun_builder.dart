import 'package:flutter/material.dart';

import '../model/noun/pronoun.dart';
import 'common/autocomplete_word.dart';

class PronounBuilder extends StatelessWidget {
  final Pronoun? pronoun;
  final void Function(Pronoun?) setPronoun;
  final List<Pronoun> pronouns;

  const PronounBuilder({
    super.key,
    required this.pronoun,
    required this.setPronoun,
    required this.pronouns,
  });

  @override
  Widget build(BuildContext context) {
    return AutocompleteWord<Pronoun>(
      label: 'Pronoun',
      value: pronoun,
      setValue: setPronoun,
      options: pronouns,
      valueToString: (pronoun) => pronoun.value,
    );
  }
}
