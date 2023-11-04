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
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import 'verb_tile.dart';

class FirstAuxiliaryVerbTile extends StatelessWidget {
  final bool isEditingVerb;
  final IndependentClause clause;
  final void Function(IndependentClause) setClause;
  final void Function() toggleEditingFirstAuxiliaryVerb;
  final void Function(ModalVerb?) setModalVerb;
  final void Function(AnyVerb?) setVerb;
  final TextEditingController? verbController;

  const FirstAuxiliaryVerbTile({
    super.key,
    required this.isEditingVerb,
    required this.clause,
    required this.setClause,
    required this.toggleEditingFirstAuxiliaryVerb,
    required this.setModalVerb,
    required this.setVerb,
    this.verbController,
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
    bool isNegativeContractionAllowed = clause.isNegative;

    bool isModalVerbFieldShown = isEditingVerb && isModalVerbEditable;

    return Column(
      children: [
        if (!clause.isBeAuxiliary)
          SentenceItemTile(
            style: Word.verb.style,
            placeholder: Label.auxiliaryVerb,
            en: auxiliaryVerbs.first,
            es: auxiliaryVerbs.firstEs,
            hint: isEditingVerb ? null : clause.firstAuxiliaryVerbDescription,
            trailing: Icon(
                isEditingVerb ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onTap: toggleEditingFirstAuxiliaryVerb,
          ),
        if (clause.isBeAuxiliary)
          VerbTile(
            clause: clause,
            isEditingVerb: isEditingVerb,
            toggleEditingVerb: toggleEditingFirstAuxiliaryVerb,
            setVerb: setVerb,
            verbEditingController: verbController,
          ),
        if (isModalVerbFieldShown)
          SentenceItemField<ModalVerb>(
            label: Label.modalVerb,
            value: clause.modalVerb,
            options: modalVerbs,
            filterValuesEn: [
              (ModalVerb e) => e.verb,
              (ModalVerb e) => e.verbContraction,
              (ModalVerb e) => e.negativeContraction,
            ],
            filterValuesEs: [
              (ModalVerb e) => e.affirmativeIEs,
              (ModalVerb e) => e.affirmativeYouEs,
              (ModalVerb e) => e.affirmativeHeEs,
              (ModalVerb e) => e.affirmativeWeEs,
              (ModalVerb e) => e.affirmativeTheyEs,
            ],
            displayStringForOption: (modalVerb) =>
                clause.conjugateModal(modalVerb) ?? '',
            onSelected: onModalVerbSelected,
            onChanged: (text) => onModalVerbChanged(),
          ),
        if (isEditingVerb)
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
                    visualDensity: VisualDensity(vertical: -1),
                  ),
                ),
              ],
            ),
          ),
        if (isEditingVerb)
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
                      enabled: isNegativeContractionAllowed,
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
                    visualDensity: VisualDensity(vertical: -1),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void onModalVerbSelected(ModalVerb modalVerb) {
    setModalVerb(modalVerb);
    //toggleEditingFirstAuxiliaryVerb();
    // showOrHideBottomAppBar();
  }

  onModalVerbChanged() {
    // setModalVerb(null);
    // showOrHideBottomAppBar();
  }

  void setAuxiliaryVerbType(AuxiliaryVerbType? type) =>
      setClause(clause.copyWith(auxiliaryVerbType: Nullable(type)));

  void setContractionType(ContractionType? type) =>
      setClause(clause.copyWith(contractionType: Nullable(type)));
}
