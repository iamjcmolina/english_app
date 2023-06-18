import 'package:flutter/material.dart';

import '../../model/phrases/participle_phrase.dart';

class PresentParticiplePhraseBuilder extends StatelessWidget {
  const PresentParticiplePhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  final PresentParticiplePhrase? phrase;
  final Function(PresentParticiplePhrase) setPhrase;

  @override
  Widget build(BuildContext context) {
    return const Text('Present participle phrase builder in progress...');
  }
}
