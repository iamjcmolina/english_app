import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/be.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../../../repository/verb_repository.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';
import 'verb_list_item.dart';

class FirstAuxiliaryVerbListItem extends StatelessWidget {
  final bool editingFirstAuxiliaryVerb;
  final IndependentClause clause;
  final void Function(IndependentClause) setClause;
  final void Function() checkCanSave;
  final void Function() toggleEditingFirstAuxiliaryVerb;
  final void Function(ModalVerb?) setModalVerb;
  final void Function(AnyVerb?) setVerb;
  final TextEditingController? verbController;

  const FirstAuxiliaryVerbListItem({
    super.key,
    required this.editingFirstAuxiliaryVerb,
    required this.clause,
    required this.setClause,
    required this.checkCanSave,
    required this.toggleEditingFirstAuxiliaryVerb,
    required this.setModalVerb,
    required this.setVerb,
    this.verbController,
  });

  @override
  Widget build(BuildContext context) {
    final verbRepository = Provider.of<VerbRepository>(context);

    final modalVerbs = verbRepository.modalVerbs();
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

    bool isModalVerbFieldShown =
        editingFirstAuxiliaryVerb && isModalVerbEditable;
    bool isModalVerbToggleShown =
        editingFirstAuxiliaryVerb && isModalVerbAllowed;
    bool isEmphasisToggleShown = editingFirstAuxiliaryVerb && isEmphasisAllowed;
    bool isContractionToggleShown =
        editingFirstAuxiliaryVerb && isContractionAllowed;
    bool isNegativeToggleShown = editingFirstAuxiliaryVerb && clause.isNegative;

    return Column(
      children: [
        if (!clause.isBeAuxiliary)
          SentenceItemTile(
            color: SentenceItem.verb.color,
            label: clause.firstAuxiliaryVerbPlaceholder,
            value: auxiliaryVerbs.first,
            valueEs: auxiliaryVerbsEs.first,
            subtitle: clause.firstAuxiliaryVerbDescription,
            trailing: Icon(editingFirstAuxiliaryVerb
                ? Icons.arrow_drop_up
                : Icons.arrow_drop_down),
            onTap: toggleEditingFirstAuxiliaryVerb,
          ),
        if (clause.isBeAuxiliary)
          VerbListItem(
            clause: clause,
            editingVerb: editingFirstAuxiliaryVerb,
            toggleEditingVerb: toggleEditingFirstAuxiliaryVerb,
            checkCanSave: checkCanSave,
            setVerb: setVerb,
            verbEditingController: verbController,
          ),
        if (isModalVerbFieldShown)
          SentenceItemField<ModalVerb>(
            label: 'Modal Verb',
            value: clause.modalVerb,
            options: modalVerbs,
            filterValues: [
              (ModalVerb e) => e.verb,
              (ModalVerb e) => e.verbContraction,
              (ModalVerb e) => e.negativeContraction,
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
        if (editingFirstAuxiliaryVerb)
          SwitchListTile(
            title: const Text('Modal Verb'),
            secondary: const Icon(Icons.add),
            dense: true,
            value: clause.isModalVerbEnabled,
            onChanged: isModalVerbToggleShown
                ? (bool value) => toggleModalVerb()
                : null,
          ),
        if (editingFirstAuxiliaryVerb)
          SwitchListTile(
            secondary: const Icon(Icons.add),
            title: const Text('Affirmative emphasis'),
            value: clause.isAffirmativeEmphasisEnabled,
            dense: true,
            onChanged: isEmphasisToggleShown
                ? (value) => toggleAffirmativeEmphasis()
                : null,
          ),
        if (editingFirstAuxiliaryVerb)
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
        if (editingFirstAuxiliaryVerb)
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
