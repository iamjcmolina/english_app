import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/tense.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/auxiliary_verb_type.dart';
import '../../../model/sentence/verb/be.dart';
import '../../../model/sentence/verb/contraction_type.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import 'verb_field.dart';

class FirstAuxiliaryVerbTile extends StatelessWidget {
  final IndependentClause clause;
  final void Function(IndependentClause) setClause;
  final bool isSettingsShown;
  final void Function() toggleFirstAuxiliaryVerbSettings;
  final void Function(AnyVerb?) setVerb;
  final TextEditingController mainVerbController;

  const FirstAuxiliaryVerbTile({
    super.key,
    required this.clause,
    required this.setClause,
    required this.isSettingsShown,
    required this.toggleFirstAuxiliaryVerbSettings,
    required this.setVerb,
    required this.mainVerbController,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    final modalVerbs = vocabularyRepository.modalVerbs();
    final auxiliaryVerbs = clause.auxiliaryVerbs;
    bool isModalVerbEditable =
        (clause.isSimplePresent || clause.isContinuousPresent) &&
            clause.isModalVerbEnabled;
    bool isModalVerbAllowed =
        clause.isSimplePresent || clause.isContinuousPresent;
    bool isEmphasisAllowed = switch (clause.tense) {
      Tense.simplePresent => clause.isAffirmative &&
          !clause.isModalVerbEnabled &&
          clause.verb is! Be,
      Tense.simplePast => clause.isAffirmative && clause.verb is! Be,
      _ => false,
    };
    bool isVerbContractionAllowed = switch (clause.tense) {
      Tense.simplePresent => !clause.isInterrogative &&
          (clause.isModalVerbEnabled &&
                  (clause.modalVerb?.hasVerbContraction ?? false) ||
              clause.verb is Be),
      Tense.simplePast || Tense.continuousPast => false,
      _ => !clause.isInterrogative,
    };

    final mainVerbLabel =
        clause.isBeAuxiliary ? ', ${clause.verbPlaceholder}' : '';

    return Column(
      children: [
        ItemTile(
          style: Word.verb.style,
          placeholder: '${Label.auxiliaryVerb}$mainVerbLabel',
          en: auxiliaryVerbs.first,
          es: auxiliaryVerbs.firstEs,
          hint: isSettingsShown ? null : clause.firstAuxiliaryVerbDescription,
          trailing: Icon(
              isSettingsShown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleFirstAuxiliaryVerbSettings,
          isRequired: clause.isBeAuxiliary,
        ),
        if (isSettingsShown) ...[
          if (clause.isBeAuxiliary)
            VerbField(
              clause: clause,
              setVerb: setVerb,
              controller: mainVerbController,
              autofocus: false,
            ),
          if (isModalVerbEditable)
            ItemField<ModalVerb>(
              label: Label.modalVerb,
              options: modalVerbs,
              value: clause.modalVerb,
              setValue: setModalVerb,
              toEnString: (e) => clause.conjugateModal(e) ?? '',
              toEsString: (e) => clause.conjugateModalEs(e) ?? '',
              autofocus: false,
            ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Type'),
                SegmentedButton<AuxiliaryVerbType>(
                  segments: [
                    ButtonSegment(
                      value: AuxiliaryVerbType.emphasis,
                      label: const Text('Emphasis'),
                      enabled: isEmphasisAllowed,
                    ),
                    ButtonSegment(
                      value: AuxiliaryVerbType.modal,
                      label: const Text('Modal'),
                      enabled: isModalVerbAllowed,
                    ),
                  ],
                  selected: clause.auxiliaryVerbType == null
                      ? {}
                      : {clause.auxiliaryVerbType!},
                  emptySelectionAllowed: true,
                  onSelectionChanged: (e) =>
                      setAuxiliaryVerbType(e.isEmpty ? null : e.first),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -2, vertical: -2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contraction'),
                SegmentedButton<ContractionType>(
                  segments: [
                    ButtonSegment(
                      value: ContractionType.verb,
                      label: const Text('Verb'),
                      enabled: isVerbContractionAllowed,
                    ),
                    ButtonSegment(
                      value: ContractionType.negative,
                      label: const Text('Negative'),
                      enabled: clause.isNegative,
                    ),
                  ],
                  selected: clause.contractionType == null
                      ? {}
                      : {clause.contractionType!},
                  emptySelectionAllowed: true,
                  onSelectionChanged: (e) =>
                      setContractionType(e.isEmpty ? null : e.first),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -2, vertical: -2),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

  void setModalVerb(ModalVerb? modalVerb) =>
      setClause(clause.copyWith(modalVerb: Nullable(modalVerb)));

  void setAuxiliaryVerbType(AuxiliaryVerbType? type) =>
      setClause(clause.copyWith(auxiliaryVerbType: Nullable(type)));

  void setContractionType(ContractionType? type) {
    setClause(clause.copyWith(contractionType: Nullable(type)));
    mainVerbController.text = clause.conjugateVerb() ?? '';
  }
}
