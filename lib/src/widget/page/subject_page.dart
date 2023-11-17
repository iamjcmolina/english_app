import 'package:flutter/material.dart';

import '../../model/sentence/clause/independent_clause.dart';
import '../../model/sentence/noun/any_noun.dart';
import '../../model/sentence/noun/indefinite_pronoun.dart';
import '../../model/sentence/noun/subject_pronoun.dart';
import '../../model/sentence/noun/subject_type.dart';
import '../../model/sentence/phrase/gerund_phrase.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/noun_phrase.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/noun/indefinite_pronoun_form.dart';
import '../sentence/noun/subject_pronoun_form.dart';
import '../sentence/phrase/gerund_phrase_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/noun_phrase_form.dart';

class SubjectPage extends StatefulWidget {
  final IndependentClause clause;

  const SubjectPage({super.key, required this.clause});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  AnyNoun? subject;
  late SubjectType type;

  bool get isValid => subject?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    subject = widget.clause.subject;
    type = switch (subject.runtimeType) {
      NounPhrase => SubjectType.nounPhrase,
      _ => SubjectType.pronoun,
    };
    type = SubjectType.from(subject.runtimeType, SubjectType.pronoun);
  }

  @override
  Widget build(BuildContext context) {
    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<SubjectType>(
          label: const Text('Subject Type'),
          initialSelection: type,
          dropdownMenuEntries: SubjectType.values
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
          onSelected: (e) => setType(e!),
        ),
      ),
    );

    return SentenceScaffold(
      title: 'Subject',
      bottomActions: [
        IconButton(
          onPressed: isValid ? () => Navigator.pop(context, subject) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        SubjectType.pronoun => SubjectPronounForm(
            setPronoun: setSubject,
            pronoun:
                subject is SubjectPronoun ? subject as SubjectPronoun : null,
            settingsControl: settingsControl,
          ),
        SubjectType.nounPhrase => NounPhraseForm(
            setPhrase: setSubject,
            phrase: subject is NounPhrase
                ? subject as NounPhrase
                : const NounPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
        SubjectType.indefinitePronoun => IndefinitePronounForm(
            setPronoun: setSubject,
            pronoun: subject is IndefinitePronoun
                ? subject as IndefinitePronoun
                : null,
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
          ),
        SubjectType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setSubject,
            phrase: subject is InfinitivePhrase
                ? subject as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
        SubjectType.gerundPhrase => GerundPhraseForm(
            setPhrase: setSubject,
            phrase: subject is GerundPhrase
                ? subject as GerundPhrase
                : const GerundPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
      },
    );
  }

  setSubject(AnyNoun? subject) => setState(() => this.subject = subject);

  setType(SubjectType type) => setState(() => this.type = type);
}
