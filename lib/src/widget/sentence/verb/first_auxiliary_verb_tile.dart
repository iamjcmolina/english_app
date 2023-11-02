import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/tense.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/be.dart';
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
    final auxiliaryVerbsEs = clause.auxiliaryVerbsEs;
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
    bool isContractionAllowed = switch (clause.tense) {
      Tense.simplePresent => !clause.isInterrogative &&
          (clause.isModalVerbEnabled || clause.verb is Be),
      Tense.simplePast || Tense.continuousPast => false,
      _ => !clause.isInterrogative,
    };

    bool isModalVerbFieldShown = isEditingVerb && isModalVerbEditable;
    bool isModalVerbToggleShown = isEditingVerb && isModalVerbAllowed;
    bool isEmphasisToggleShown = isEditingVerb && isEmphasisAllowed;
    bool isContractionToggleShown = isEditingVerb && isContractionAllowed;
    bool isNegativeToggleShown = isEditingVerb && clause.isNegative;

    return Column(
      children: [
        if (!clause.isBeAuxiliary)
          SentenceItemTile(
            style: Word.verb.style,
            placeholder: clause.firstAuxiliaryVerbPlaceholder,
            en: auxiliaryVerbs.first,
            es: auxiliaryVerbsEs.first,
            hint: clause.firstAuxiliaryVerbDescription,
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
            label: 'Modal Verb',
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
                clause.modalVerbAsString(modalVerb),
            onSelected: onModalVerbSelected,
            onChanged: (text) => onModalVerbChanged(),
          ),
        if (isEditingVerb)
          SwitchListTile(
            title: const Text('Modal Verb'),
            secondary: const Icon(Icons.add),
            dense: true,
            value: clause.isModalVerbEnabled,
            onChanged: isModalVerbToggleShown
                ? (bool value) => toggleModalVerb()
                : null,
          ),
        if (isEditingVerb)
          SwitchListTile(
            secondary: const Icon(Icons.add),
            title: const Text('Affirmative emphasis'),
            value: clause.isAffirmativeEmphasisEnabled,
            dense: true,
            onChanged: isEmphasisToggleShown
                ? (value) => toggleAffirmativeEmphasis()
                : null,
          ),
        if (isEditingVerb)
          SwitchListTile(
            title: const Text('Contraction'),
            dense: true,
            secondary: const Icon(Icons.compress),
            value: clause.isVerbContractionEnabled,
            onChanged: isContractionToggleShown
                ? (value) {
                    setClause(clause.copyWith(
                      isVerbContractionEnabled:
                          !clause.isVerbContractionEnabled,
                      isNegativeContractionEnabled: false,
                    ));
                    if (verbController != null) {
                      verbController!.text = clause.verbAsString();
                    }
                  }
                : null,
          ),
        if (isEditingVerb)
          SwitchListTile(
            title: const Text('Negative Contraction'),
            dense: true,
            secondary: const Icon(Icons.compress),
            value: clause.isNegativeContractionEnabled,
            onChanged: isNegativeToggleShown
                ? (value) => toggleNegativeContraction()
                : null,
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

  toggleModalVerb() => setClause(clause.copyWith(
        isModalVerbEnabled: !clause.isModalVerbEnabled,
        isAffirmativeEmphasisEnabled: false,
        isNegativeContractionEnabled: false,
      ));

  toggleAffirmativeEmphasis() => setClause(clause.copyWith(
        isAffirmativeEmphasisEnabled: !clause.isAffirmativeEmphasisEnabled,
        isModalVerbEnabled: false,
        isVerbContractionEnabled: false,
      ));

  toggleNegativeContraction() => setClause(clause.copyWith(
        isNegativeContractionEnabled: !clause.isNegativeContractionEnabled,
        isVerbContractionEnabled: false,
        isModalVerbEnabled: false,
        isAffirmativeEmphasisEnabled: false,
      ));
}
