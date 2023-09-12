import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause_settings.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../model/sentence/verb/undefined_modal_verb.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class FirstAuxiliaryVerbListItem extends StatelessWidget {
  final Color color;
  final bool editingFirstAuxiliaryVerb;
  final bool isBeAuxiliary;
  final String? value;
  final ModalVerb? modalVerb;
  final IndependentClauseSettings settings;
  final void Function(IndependentClauseSettings settings) setSettings;
  final void Function(ModalVerb? modalVerb) setModalVerb;
  final void Function() showOrHideBottomAppBar;
  final void Function() toggleEditingFirstAuxiliaryVerb;
  final void Function() toggleModalVerb;
  final void Function() toggleAffirmativeEmphasis;
  final void Function() toggleContraction;
  final void Function() toggleNegativeContraction;

  const FirstAuxiliaryVerbListItem({
    super.key,
    required this.color,
    required this.editingFirstAuxiliaryVerb,
    required this.isBeAuxiliary,
    required this.value,
    this.modalVerb,
    required this.settings,
    required this.setSettings,
    required this.setModalVerb,
    required this.showOrHideBottomAppBar,
    required this.toggleEditingFirstAuxiliaryVerb,
    required this.toggleModalVerb,
    required this.toggleAffirmativeEmphasis,
    required this.toggleContraction,
    required this.toggleNegativeContraction,
  });

  @override
  Widget build(BuildContext context) {
    bool isAffirmativeClause = settings.clauseType == ClauseType.affirmative;
    bool isNegativeClause = settings.clauseType == ClauseType.negative;
    bool isSimplePresent = settings.tense == Tense.simplePresent;
    bool isSimplePast = settings.tense == Tense.simplePast;
    bool isSimplePresentOrPast = isSimplePresent || isSimplePast;
    bool showModalVerbField = editingFirstAuxiliaryVerb && isSimplePresent && settings.modalVerb;
    bool allowModalVerb = settings.tense == Tense.simplePresent;
    bool allowEmphasis = settings.clauseType == ClauseType.affirmative
        && settings.tense == Tense.simplePresent
        && settings.tense == Tense.simplePast;
    bool allowNegativeToBeContraction = settings.clauseType == ClauseType.negative;

    return Column(
      children: [
        SentenceItemTile(
          color: color,
          label: 'First Auxiliary Verb',
          value: value,
          subtitle: settings.firstAuxiliaryVerbConfig,
          trailing: Icon(editingFirstAuxiliaryVerb? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingFirstAuxiliaryVerb,
        ),
      ],
    );
  }
}
