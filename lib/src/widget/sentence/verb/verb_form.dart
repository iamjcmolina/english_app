import 'package:flutter/material.dart';

import '../../../model/sentence/noun/pronoun.dart';

class VerbForm extends StatefulWidget {
  final List<Pronoun> pronouns;
  final void Function(Pronoun?) setPronoun;
  final Pronoun? pronoun;
  final Function(bool) setShowBottomAppBar;

  const VerbForm({
    super.key,
    required this.pronouns,
    required this.setPronoun,
    required this.setShowBottomAppBar,
    this.pronoun,
  });

  @override
  State<VerbForm> createState() => _VerbFormState();
}

class _VerbFormState extends State<VerbForm> {


  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
