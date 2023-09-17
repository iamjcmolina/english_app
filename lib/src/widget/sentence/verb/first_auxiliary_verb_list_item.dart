import 'package:flutter/material.dart';

import '../../../model/sentence/clause/independent_clause.dart';
import '../../../model/sentence/clause/independent_clause_settings.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/independent_clause_part_color.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/modal_verb.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';
import 'verb_list_item.dart';

class FirstAuxiliaryVerbListItem extends StatelessWidget {
  final bool editingFirstAuxiliaryVerb;
  final IndependentClause clause;
  final void Function(IndependentClauseSettings settings) setSettings;
  final void Function() showOrHideBottomAppBar;
  final void Function() toggleEditingFirstAuxiliaryVerb;
  final void Function(ModalVerb? modalVerb) setModalVerb;
  final void Function(AnyVerb? verb) setVerb;
  final TextEditingController? verbEditingController;

  const FirstAuxiliaryVerbListItem({
    super.key,
    required this.editingFirstAuxiliaryVerb,
    required this.clause,
    required this.setSettings,
    required this.showOrHideBottomAppBar,
    required this.toggleEditingFirstAuxiliaryVerb,
    required this.setModalVerb,
    required this.setVerb,
    this.verbEditingController,
  });

  IndependentClauseSettings get settings => clause.settings;

  @override
  Widget build(BuildContext context) {
    bool isModalVerbFieldShown = editingFirstAuxiliaryVerb && clause.isModalVerbEditable;
    bool isModalVerbToggleShown = editingFirstAuxiliaryVerb && clause.isModalVerbAllowed;
    bool isEmphasisToggleShown = editingFirstAuxiliaryVerb && clause.isEmphasisAllowed;
    bool isContractionToggleShown = editingFirstAuxiliaryVerb && clause.isContractionAllowed;
    bool isNegativeToggleShown = editingFirstAuxiliaryVerb && clause.isNegativeContractionAllowed;

    String safeAuxiliary = clause.auxiliaries.elementAt(0) ?? '<First Auxiliary Verb>';

    return Column(
      children: [
        if (!clause.isBeAuxiliary) SentenceItemTile(
          color: IndependentClausePartColor.verb.color,
          label: 'First Auxiliary Verb',
          value: safeAuxiliary,
          subtitle: clause.auxiliaryConfig,
          trailing: Icon(editingFirstAuxiliaryVerb? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingFirstAuxiliaryVerb,
        ),
        if(clause.isBeAuxiliary) VerbListItem(
          clause: clause,
          editingVerb: editingFirstAuxiliaryVerb,
          toggleEditingVerb: toggleEditingFirstAuxiliaryVerb,
          showOrHideBottomAppBar: showOrHideBottomAppBar,
          setVerb: setVerb,
          verbEditingController: verbEditingController,
        ),
        if (isModalVerbFieldShown) SentenceItemField<ModalVerb>(
          label: 'Modal Verb',
          value: clause.modalVerb,
          options: ModalVerb.modalVerbs,
          displayStringForOption: (modalVerb) => modalVerbToString(modalVerb),
          onSelected: onModalVerbSelected,
          onCleaned: () => onModalVerbCleaned(),
          onChanged: (text) => onModalVerbChanged(),
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Modal Verb'),
          secondary: const Icon(Icons.add),
          dense: true,
          value: settings.modalVerb,
          onChanged: isModalVerbToggleShown?
              (bool value) => toggleModalVerb() : null,
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          secondary: const Icon(Icons.add),
          title: const Text('Affirmative present or past emphasis'),
          value: settings.affirmativeEmphasis,
          dense: true,
          onChanged: isEmphasisToggleShown?
              (value) => toggleAffirmativeEmphasis() : null,
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Contraction'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.contraction,
          onChanged: isContractionToggleShown?
              (value) => toggleContraction() : null,
        ),
        if (editingFirstAuxiliaryVerb) SwitchListTile(
          title: const Text('Negative Contraction'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.negativeContraction,
          onChanged: isNegativeToggleShown?
              (value) => toggleNegativeContraction() : null,
        ),
      ],
    );
  }

  void onModalVerbSelected(ModalVerb modalVerb) {
    setModalVerb(modalVerb);
    //toggleEditingFirstAuxiliaryVerb();
    // showOrHideBottomAppBar();
  }

  onModalVerbCleaned() {
    // onModalVerbChanged();
    // toggleEditingFirstAuxiliaryVerb();
  }

  onModalVerbChanged() {
    // setModalVerb(null);
    // showOrHideBottomAppBar();
  }

  toggleModalVerb() => setSettings(settings.copyWith(
    modalVerb: !settings.modalVerb,
    affirmativeEmphasis: false,
    negativeContraction: false,
  ));

  toggleAffirmativeEmphasis() => setSettings(settings.copyWith(
    affirmativeEmphasis: !settings.affirmativeEmphasis,
    modalVerb: false,
    contraction: false,
  ));

  toggleContraction() {
    setSettings(settings.copyWith(
      contraction: !settings.contraction,
      negativeContraction: false,
    ));
    if (verbEditingController != null) {
      verbEditingController!.text =
          AnyVerb.verbToString(clause.safeVerb, clause.safeSubject, settings);
    }
  }

  toggleNegativeContraction() => setSettings(settings.copyWith(
    negativeContraction: !settings.negativeContraction,
    contraction: false,
    modalVerb: false,
    affirmativeEmphasis: false,
  ));

  String modalVerbToString(ModalVerb modalVerb) =>
      settings.clauseType == ClauseType.negative
          ? modalVerb.negativeValue(settings.contraction, settings.negativeContraction)
          : modalVerb.affirmativeValue(!settings.isInterrogative && settings.contraction);
}
