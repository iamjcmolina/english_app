import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/sentence/clause/independent_clause.dart';
import '../../model/sentence/noun/any_noun.dart';
import '../../model/sentence/noun/indefinite_pronoun.dart';
import '../../model/sentence/noun/noun_type.dart';
import '../../model/sentence/noun/pronoun.dart';
import '../../model/sentence/phrase/gerund_phrase.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/noun_phrase.dart';
import '../../repository/vocabulary_repository.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/noun/indefinite_pronoun_form.dart';
import '../sentence/noun/pronoun_form.dart';
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
  late NounType type;

  bool get isValid => subject?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    subject = widget.clause.subject;
    type = switch (subject.runtimeType) {
      NounPhrase => NounType.nounPhrase,
      _ => NounType.pronoun,
    };
    type = NounType.from(subject.runtimeType, NounType.pronoun);
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<NounType>(
          label: const Text('Subject Type'),
          initialSelection: type,
          dropdownMenuEntries: NounType.values
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
        NounType.nounPhrase => NounPhraseForm(
            setPhrase: setSubject,
            phrase: subject is NounPhrase
                ? subject as NounPhrase
                : const NounPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
        NounType.indefinitePronoun => IndefinitePronounForm(
            setPronoun: setSubject,
            pronoun: subject is IndefinitePronoun
                ? subject as IndefinitePronoun
                : null,
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
          ),
        NounType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setSubject,
            phrase: subject is InfinitivePhrase
                ? subject as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
        NounType.gerundPhrase => GerundPhraseForm(
            setPhrase: setSubject,
            phrase: subject is GerundPhrase
                ? subject as GerundPhrase
                : const GerundPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.clause.isNegative,
            isPlural: widget.clause.hasPluralSubject,
          ),
        _ => PronounForm(
            pronouns: vocabularyRepository.subjectPronouns(),
            setPronoun: setSubject,
            pronoun: subject is Pronoun ? subject as Pronoun : null,
            settingsControl: settingsControl,
          ),
      },
    );
  }

  setSubject(AnyNoun? subject) => setState(() => this.subject = subject);

  setType(NounType type) => setState(() => this.type = type);
}
