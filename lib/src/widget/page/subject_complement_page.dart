import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/sentence/adjective/adjective.dart';
import '../../model/sentence/noun/pronoun.dart';
import '../../model/sentence/noun/subject_complement.dart';
import '../../model/sentence/noun/subject_complement_type.dart';
import '../../model/sentence/phrase/adjective_plus_complement.dart';
import '../../model/sentence/phrase/adverb_plus_adjective.dart';
import '../../model/sentence/phrase/infinitive_phrase.dart';
import '../../model/sentence/phrase/noun_phrase.dart';
import '../../repository/vocabulary_repository.dart';
import '../common/sentence_scaffold.dart';
import '../sentence/adjective/adjective_form.dart';
import '../sentence/noun/pronoun_form.dart';
import '../sentence/phrase/adjective_plus_complement_form.dart';
import '../sentence/phrase/adverb_plus_adjective_form.dart';
import '../sentence/phrase/infinitive_phrase_form.dart';
import '../sentence/phrase/noun_phrase_form.dart';

class SubjectComplementPage extends StatefulWidget {
  final SubjectComplement? complement;
  final bool isNegative;
  final bool isPlural;

  const SubjectComplementPage({
    super.key,
    required this.complement,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<SubjectComplementPage> createState() => _SubjectComplementState();
}

class _SubjectComplementState extends State<SubjectComplementPage> {
  SubjectComplement? complement;
  late SubjectComplementType type;

  bool get isValid => complement?.isValid ?? false;

  @override
  void initState() {
    super.initState();
    complement = widget.complement;
    type = switch (complement.runtimeType) {
      NounPhrase => SubjectComplementType.nounPhrase,
      Adjective => SubjectComplementType.adjective,
      _ => SubjectComplementType.possessivePronoun,
    };
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    List<Pronoun> pronouns = vocabularyRepository.possessivePronouns();

    final settingsControl = Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<SubjectComplementType>(
          initialSelection: type,
          label: const Text('Subject Complement Type'),
          dropdownMenuEntries: SubjectComplementType.values
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
          onSelected: (e) => setType(e!),
        ),
      ),
    );

    return SentenceScaffold(
      title: 'Subject complement',
      bottomActions: [
        IconButton(
          onPressed: isValid ? () => Navigator.pop(context, complement) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        SubjectComplementType.possessivePronoun => PronounForm(
            pronouns: pronouns,
            setPronoun: setComplement,
            pronoun: complement is Pronoun ? complement as Pronoun : null,
            settingsControl: settingsControl,
          ),
        SubjectComplementType.nounPhrase => NounPhraseForm(
            setPhrase: setComplement,
            phrase: complement is NounPhrase
                ? complement as NounPhrase
                : const NounPhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        SubjectComplementType.infinitivePhrase => InfinitivePhraseForm(
            setPhrase: setComplement,
            phrase: complement is InfinitivePhrase
                ? complement as InfinitivePhrase
                : const InfinitivePhrase(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        SubjectComplementType.adverbPlusAdjective => AdverbPlusAdjectiveForm(
            setPhrase: setComplement,
            phrase: complement is AdverbPlusAdjective
                ? complement as AdverbPlusAdjective
                : const AdverbPlusAdjective(),
            settingsControl: settingsControl,
            isPlural: widget.isPlural,
          ),
        SubjectComplementType.adjectivePlusComplement =>
          AdjectivePlusComplementForm(
            setPhrase: setComplement,
            phrase: complement is AdjectivePlusComplement
                ? complement as AdjectivePlusComplement
                : const AdjectivePlusComplement(),
            settingsControl: settingsControl,
            isNegative: widget.isNegative,
            isPlural: widget.isPlural,
          ),
        _ => AdjectiveForm(
            setAdjective: setComplement,
            adjective: complement is Adjective ? complement as Adjective : null,
            settingsControl: settingsControl,
          ),
      },
    );
  }

  setComplement(SubjectComplement? complement) =>
      setState(() => this.complement = complement);

  setType(SubjectComplementType type) => setState(() => this.type = type);
}
