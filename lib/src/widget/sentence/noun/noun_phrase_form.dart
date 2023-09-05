import 'package:flutter/material.dart';

import '../../../model/sentence/noun/pronoun.dart';

class NounPhraseForm extends StatefulWidget {
  final void Function(Pronoun?) setPronoun;
  final Pronoun? pronoun;

  const NounPhraseForm({
    super.key,
    required this.setPronoun,
    this.pronoun,
  });

  @override
  State<NounPhraseForm> createState() => _NounPhraseFormState();
}

class _NounPhraseFormState extends State<NounPhraseForm> {
  bool settingDeterminer = false;
  bool settingNoun = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ],
    );
  }
}
