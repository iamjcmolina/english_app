import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';

class VerbListItem extends StatelessWidget {
  final IndependentClause clause;
  final bool editingVerb;
  final void Function() toggleEditingVerb;
  final void Function() checkCanSave;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController? verbEditingController;
  final bool show;

  const VerbListItem({
    super.key,
    required this.clause,
    required this.editingVerb,
    required this.toggleEditingVerb,
    required this.checkCanSave,
    required this.setVerb,
    this.verbEditingController,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) {
      const SizedBox.shrink();
    }
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    final auxiliaryVerbLabel =
        clause.isBeAuxiliary ? ', ${clause.firstAuxiliaryVerbPlaceholder}' : '';

    return Column(
      children: [
        SentenceItemTile(
          style: SentenceItem.verb.style,
          placeholder: '${clause.verbPlaceholder}$auxiliaryVerbLabel',
          en: clause.verbAsString(),
          es: clause.verbAsStringEs(),
          hint: clause.isBeAuxiliary
              ? clause.firstAuxiliaryVerbDescription
              : null,
          trailing:
              Icon(editingVerb ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingVerb,
          isRequired: true,
        ),
        if (editingVerb)
          SentenceItemField<AnyVerb>(
            label: clause.verbPlaceholder,
            value: clause.verb,
            options: vocabularyRepository.verbs(),
            filterValuesEn: [
              (AnyVerb e) => e.infinitive,
              (AnyVerb e) => e.pastParticiple,
              (AnyVerb e) => e.progressive,
            ],
            filterValuesEs: [
              (AnyVerb e) => e.infinitiveEs,
              (AnyVerb e) => e.pastParticipleEs,
              (AnyVerb e) => e.progressiveEs,
              (AnyVerb e) => e.presentIEs,
              (AnyVerb e) => e.pastIEs,
              (AnyVerb e) => e.futureIEs,
              (AnyVerb e) => e.conditionalIEs,
            ],
            displayStringForOption: (verb) => clause.verbAsString(verb),
            onSelected: onVerbSelected,
            onChanged: (text) => onVerbChanged(),
            textController: verbEditingController,
          ),
      ],
    );
  }

  void onVerbSelected(AnyVerb verb) {
    setVerb(verb);
    toggleEditingVerb();
    checkCanSave();
  }

  onVerbChanged() {
    setVerb(null);
    checkCanSave();
  }
}
