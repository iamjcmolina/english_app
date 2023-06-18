import 'package:flutter/material.dart';

import '../../model/phrase/gerund_phrase/gerund_phrase.dart';

class GerundPhraseBuilder extends StatelessWidget {
  GerundPhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  final GerundPhrase? phrase;
  final Function(GerundPhrase) setPhrase;

  @override
  Widget build(BuildContext context) {
    return const Text('Gerund phrase builder in progress...');
  }
}
