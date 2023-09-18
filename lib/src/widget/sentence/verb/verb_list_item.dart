import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../service/vocabulary_service.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class VerbListItem extends StatelessWidget {
  final IndependentClause clause;
  final bool editingVerb;
  final void Function() toggleEditingVerb;
  final void Function() showOrHideBottomAppBar;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController? verbEditingController;
  final bool hide;

  const VerbListItem({
    super.key,
    required this.clause,
    required this.editingVerb,
    required this.toggleEditingVerb,
    required this.showOrHideBottomAppBar,
    required this.setVerb,
    this.verbEditingController,
    this.hide = false,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<AnyVerb> verbs = vocabularyService.verbs();

    String verbLabel = AnyVerb.verbToString(clause.undefinedVerb, clause.safeSubject, clause.settings);
    String auxiliaryVerbLabel = clause.isBeAuxiliary
        ? ', ${clause.undefinedFirstAuxiliaryVerb}' : '';

    return hide? const SizedBox.shrink() : Column(
      children: [
        SentenceItemTile(
          color: IndependentClausePartColor.verb.color,
          label: '$verbLabel$auxiliaryVerbLabel',
          value: clause.verb == null ? null
              : AnyVerb.verbToString(clause.safeVerb, clause.safeSubject, clause.settings),
          subtitle: clause.isBeAuxiliary? clause.auxiliaryConfig : null,
          trailing: Icon(editingVerb? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingVerb,
        ),
        if(editingVerb) SentenceItemField<AnyVerb>(
          label: AnyVerb.verbToString(clause.undefinedVerb, clause.safeSubject, clause.settings),
          value: clause.verb,
          options: verbs,
          displayStringForOption: (verb) => AnyVerb.verbToString(verb, clause.safeSubject, clause.settings),
          onSelected: onVerbSelected,
          onCleaned: () => onVerbCleaned(),
          onChanged: (text) => onVerbChanged(),
          textEditingController: verbEditingController,
        ),
      ],
    );
  }

  void onVerbSelected(AnyVerb verb) {
    setVerb(verb);
    toggleEditingVerb();
    //showOrHideBottomAppBar();
  }

  onVerbCleaned() {
    onVerbChanged();
    // toggleEditingVerb();
  }

  onVerbChanged() {
    setVerb(null);
    showOrHideBottomAppBar();
  }
}
