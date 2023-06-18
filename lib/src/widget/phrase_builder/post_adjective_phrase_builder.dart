import 'package:flutter/material.dart';

import '../../model/phrases/adjective_phrase.dart';

class PostAdjectivePhraseBuilder extends StatelessWidget {
  PostAdjectivePhraseBuilder({super.key, required this.phrase, required this.setPhrase});
  final AdjectivePhrase? phrase;
  final Function(AdjectivePhrase) setPhrase;

  @override
  Widget build(BuildContext context) {
    return const Text('Adjective phrase post modifier builder in progress...');
  }
}
