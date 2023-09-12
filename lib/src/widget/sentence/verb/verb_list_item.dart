import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause_settings.dart';
import '../../../model/sentence/noun/subject.dart';
import '../../../model/sentence/noun/undefined_subject.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence/verb/be.dart';
import '../../../model/sentence/verb/undefined_verb.dart';
import '../../../model/sentence/verb/value/verb_tense.dart';
import '../../../service/vocabulary_service.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class VerbListItem extends StatelessWidget {
  final Color color;
  final AnyVerb? verb;
  final Subject? subject;
  final bool isBeAuxiliary;
  final bool editingVerb;
  final void Function() toggleEditingVerb;
  final void Function() showOrHideBottomAppBar;
  final IndependentClauseSettings settings;
  final void Function(AnyVerb? verb) setVerb;
  final void Function() toggleModalVerb;
  final void Function() toggleContraction;
  final void Function() toggleNegativeContraction;
  final TextEditingController? textEditingController;

  const VerbListItem({
    super.key,
    required this.color,
    this.verb,
    this.subject,
    required this.isBeAuxiliary,
    required this.editingVerb,
    required this.toggleEditingVerb,
    required this.settings,
    required this.setVerb,
    required this.showOrHideBottomAppBar,
    required this.toggleModalVerb,
    required this.toggleContraction,
    required this.toggleNegativeContraction,
    this.textEditingController,
  });

  AnyVerb get safeVerb => verb ?? const UndefinedVerb();
  Subject get safeSubject => subject ?? const UndefinedSubject();

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<AnyVerb> verbs = vocabularyService.verbs();

    return Column(
      children: [
        SentenceItemTile(
          color: color,
          label: isBeAuxiliary? 'Verb, First Auxiliary Verb' : 'Verb',
          value: AnyVerb.verbToString(safeVerb, safeSubject, settings),
          subtitle: isBeAuxiliary? settings.firstAuxiliaryVerbConfig : null,
          trailing: Icon(editingVerb? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: toggleEditingVerb,
        ),
        if(editingVerb) SentenceItemField<AnyVerb>(
          label: 'Verb',
          value: verb,
          options: verbs,
          displayStringForOption: (verb) => AnyVerb.verbToString(verb, safeSubject, settings),
          onSelected: onVerbSelected,
          onCleaned: () => onVerbCleaned(),
          onChanged: (text) => onVerbChanged(),
          textEditingController: textEditingController,
        ),
        if (editingVerb && isBeAuxiliary) SwitchListTile(
          title: const Text('Modal Verb'),
          secondary: const Icon(Icons.add),
          dense: true,
          value: settings.modalVerb,
          onChanged: settings.isSimplePresent? (bool value) => toggleModalVerb() : null,
        ),
        if (editingVerb && isBeAuxiliary) SwitchListTile(
          title: const Text('Contraction'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.contraction,
          onChanged: (value) => toggleContraction(),
        ),
        if (editingVerb && isBeAuxiliary) SwitchListTile(
          title: const Text('Negative Contraction'),
          dense: true,
          secondary: const Icon(Icons.compress),
          value: settings.negativeContraction,
          onChanged: settings.isNegative
              ? (value) => toggleNegativeContraction()
              : null,
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
