import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';

class VerbTile extends StatelessWidget {
  final bool isShown;
  final bool isEditingVerb;
  final IndependentClause clause;
  final void Function() toggleEditingVerb;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController? verbEditingController;

  const VerbTile({
    super.key,
    this.isShown = true,
    required this.isEditingVerb,
    required this.clause,
    required this.toggleEditingVerb,
    required this.setVerb,
    this.verbEditingController,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShown) {
      const SizedBox.shrink();
    }
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    final auxiliaryVerbLabel =
        clause.isBeAuxiliary ? ', ${Label.auxiliaryVerb}' : '';
    final auxiliaryVerbLabelEs =
        clause.isBeAuxiliary ? ', ${Label.auxiliaryVerbEs}' : '';

    return Column(
      children: [
        SentenceItemTile(
          style: Word.verb.style,
          placeholder: '${clause.verbPlaceholder}$auxiliaryVerbLabel',
          placeholderEs: '${clause.verbPlaceholderEs}$auxiliaryVerbLabelEs',
          en: clause.conjugateVerb(),
          es: clause.conjugateVerbEs(),
          hint: clause.isBeAuxiliary && !isEditingVerb
              ? clause.firstAuxiliaryVerbDescription
              : null,
          trailing:
              Icon(isEditingVerb ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingVerb,
          isRequired: true,
        ),
        if (isEditingVerb)
          SentenceItemField<AnyVerb>(
            label: clause.verbPlaceholder,
            value: clause.verb,
            options: vocabularyRepository.verbs(),
            getEnWords: [
              (AnyVerb e) => e.infinitive,
              (AnyVerb e) => e.pastParticiple,
              (AnyVerb e) => e.progressive,
            ],
            getEsWords: [
              (AnyVerb e) => e.infinitiveEs,
              (AnyVerb e) => e.pastParticipleEs,
              (AnyVerb e) => e.progressiveEs,
              (AnyVerb e) => e.presentIEs,
              (AnyVerb e) => e.pastIEs,
              (AnyVerb e) => e.futureIEs,
              (AnyVerb e) => e.conditionalIEs,
            ],
            displayStringForOption: (verb) => clause.conjugateVerb(verb) ?? '',
            setValue: (verb) => setVerb(verb),
            textController: verbEditingController,
          ),
      ],
    );
  }
}
