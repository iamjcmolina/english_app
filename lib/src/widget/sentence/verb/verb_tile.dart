import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/word.dart';
import '../../common/item_tile.dart';
import 'verb_field.dart';

class VerbTile extends StatelessWidget {
  final IndependentClause clause;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController controller;
  final void Function() toggleField;
  final bool isFieldShown;
  final bool isShown;

  const VerbTile({
    super.key,
    required this.clause,
    required this.setVerb,
    required this.controller,
    required this.toggleField,
    required this.isFieldShown,
    required this.isShown,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShown) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (!isFieldShown)
          ItemTile(
            style: Word.verb.style,
            placeholder: clause.verbPlaceholder,
            en: clause.conjugateVerb(),
            es: clause.conjugateVerbEs(),
            hint: clause.isBeAuxiliary && !isFieldShown
                ? clause.firstAuxiliaryVerbDescription
                : null,
            trailing: const Icon(Icons.edit),
            onTap: toggleField,
            isRequired: true,
          ),
        if (isFieldShown)
          VerbField(
            clause: clause,
            setVerb: setVerb,
            onAccept: toggleField,
            controller: controller,
          ),
      ],
    );
  }
}
