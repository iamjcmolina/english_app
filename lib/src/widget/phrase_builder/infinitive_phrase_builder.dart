import 'package:flutter/material.dart';

import '../../model/phrase/infinitive_phrase/infinitive_phrase.dart';

class InfinitivePhraseBuilder extends StatelessWidget {
  InfinitivePhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  final InfinitivePhrase? phrase;
  final Function(InfinitivePhrase) setPhrase;

  @override
  Widget build(BuildContext context) {
    return const Text('Infinitive phrase builder in progress...');
  }
}
