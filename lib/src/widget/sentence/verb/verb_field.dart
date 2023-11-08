import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_field.dart';

class VerbField extends StatelessWidget {
  final IndependentClause clause;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController controller;
  final void Function()? onAccept;
  final bool autofocus;

  const VerbField({
    super.key,
    required this.clause,
    required this.setVerb,
    required this.controller,
    this.onAccept,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemField<AnyVerb>(
      label: clause.verbPlaceholder,
      options: vocabularyRepository.verbs(),
      value: clause.verb,
      setValue: setVerb,
      onAccept: onAccept,
      toEnString: (verb) => clause.conjugateVerb(verb) ?? '',
      toEsString: (verb) => clause.conjugateVerbEs(verb) ?? '',
      controller: controller,
      autofocus: autofocus,
    );
  }
}
