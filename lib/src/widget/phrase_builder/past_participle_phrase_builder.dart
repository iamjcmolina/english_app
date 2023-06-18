import 'package:flutter/material.dart';

import '../../model/phrase/participle_phrase/past_participle_phrase.dart';

class PastParticiplePhraseBuilder extends StatelessWidget {
  const PastParticiplePhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  final PastParticiplePhrase? phrase;
  final Function(PastParticiplePhrase) setPhrase;

  @override
  Widget build(BuildContext context) {
    return const Text('Present participle phrase builder in progress...');
  }
}
