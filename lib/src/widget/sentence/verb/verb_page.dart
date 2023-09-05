import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/clause/independent_clause_options.dart';
import '../../../model/sentence/clause/value/clause_type.dart';
import '../../../model/sentence/clause/value/tense.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../service/vocabulary_service.dart';
import '../../root_layout.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

enum VerbTense {
  infinitive('Infinitive'),
  present('Present'),
  past('Past'),
  presentParticiple('Present Participle'),
  pastParticiple('Past Participle');

  final String name;

  const VerbTense(this.name);
}

class VerbPage extends StatefulWidget {
  final AnyVerb? verb;
  final IndependentClauseOptions options;

  const VerbPage({super.key, this.verb, required this.options});

  @override
  State<VerbPage> createState() => _VerbPageState();
}

class _VerbPageState extends State<VerbPage> {
  AnyVerb? verb;
  bool showBottomAppBar = false;
  bool settingVerb = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    List<AnyVerb> verbs = vocabularyService.verbs();
    const Color pronounColor = Colors.deepPurpleAccent;

    return RootLayout(
      title: 'Subject',
      showBottomAppBar: showBottomAppBar,
      bottomAppBarChildren: [
        IconButton(
          onPressed: () => Navigator.pop(context, verb),
          icon: const Icon(Icons.save)
        ),
      ],
      child: Column(
        children: [
          ListTile(
            title: Text(
              verb == null? '<Verb>' : verb.toString(),
              style: const TextStyle(color: pronounColor),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      if(!settingVerb) SentenceItemTile(
                        color: pronounColor,
                        label: 'Verb',
                        value: verb?.value,
                        trailing: const Icon(Icons.edit),
                        onTap: () => toggleSettingPronoun(),
                      ),
                      if(settingVerb) SentenceItemField<AnyVerb>(
                        label: 'Verb',
                        value: verb,
                        options: verbs,
                        displayStringForOption: (verb) => verb.value,
                        onSelected: onVerbSelected,
                        onCleaned: () => onVerbCleaned(),
                        onChanged: (text) => onVerbChanged(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onVerbSelected(AnyVerb verb) {
    setVerb(verb);
    toggleSettingPronoun();
    setShowBottomAppBar(true);
  }

  onVerbCleaned() {
    onVerbChanged();
    toggleSettingPronoun();
  }

  onVerbChanged() {
    setVerb(null);
    setShowBottomAppBar(false);
  }

  toggleSettingPronoun() => setState(() => settingVerb = !settingVerb);

  setVerb(AnyVerb? verb) => setState(() => this.verb = verb);

  setShowBottomAppBar(bool show) => setState(() => showBottomAppBar = show);

  VerbTense get verbTense {
    if (widget.options.clauseType == ClauseType.affirmative) {
      if (widget.options.tense == Tense.simplePresent) {
        return widget.options.modalVerb || (!validVerb.isBe && widget.options.affirmativeEmphasis)
            ? VerbTense.infinitive
            : VerbTense.present;
      } else if (widget.options.tense == Tense.simplePast) {
        return !validVerb.isBe && widget.options.affirmativeEmphasis ? VerbTense.infinitive : VerbTense.past;
      }
    } else if (widget.options.type == ClauseType.negative && widget.options.tense == Tense.simplePresent) {
      return widget.options.modalVerb || !validVerb.isBe ? VerbTense.infinitive : VerbTense.present;
    }
    if (widget.options.tense == Tense.simplePresent) {
      return validVerb.isBe && widget.options.modalVerb? VerbTense.infinitive : VerbTense.present;
    } else if (widget.options.tense == Tense.simplePast) {
      return VerbTense.infinitive;
    } else if (widget.options.tense == Tense.simpleFuture) {
      return VerbTense.infinitive;
    } else if (widget.options.tense == Tense.simplePresentPerfect
        || widget.options.tense == Tense.simplePastPerfect
        || widget.options.tense == Tense.simpleFuturePerfect) {
      return VerbTense.pastParticiple;
    } else {
      return VerbTense.presentParticiple;
    }
  }

  @override
  void initState() {
    super.initState();
    verb = widget.verb;
    showBottomAppBar = verb != null;
  }
}
