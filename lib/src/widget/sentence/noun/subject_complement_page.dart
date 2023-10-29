import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/sentence/noun/subject_complement.dart';
import '../../../model/sentence/noun/value/complement-type.dart';
import '../../../model/sentence/phrase/noun_phrase.dart';
import '../../../repository/noun_repository.dart';
import '../../sentence_scaffold.dart';
import 'adjective_form.dart';
import 'noun_phrase_form.dart';
import 'pronoun_form.dart';

class SubjectComplementPage extends StatefulWidget {
  final SubjectComplement? complement;

  const SubjectComplementPage({
    super.key,
    required this.complement,
  });

  @override
  State<SubjectComplementPage> createState() => _SubjectComplementState();
}

class _SubjectComplementState extends State<SubjectComplementPage> {
  late ComplementType type;
  SubjectComplement? complement;
  bool canSave = false;

  @override
  void initState() {
    super.initState();
    complement = widget.complement;
    canSave = complement != null;
    type = switch (complement.runtimeType) {
      NounPhrase => ComplementType.nounPhrase,
      Adjective => ComplementType.adjective,
      _ => ComplementType.possessivePronoun,
    };
  }

  @override
  Widget build(BuildContext context) {
    final nounRepository = Provider.of<NounRepository>(context);

    List<Pronoun> pronouns = nounRepository.possessivePronouns();

    final settingsControl = Center(
      child: DropdownButton<ComplementType>(
        value: type,
        onChanged: (ComplementType? value) => setType(value!),
        items: ComplementType.values
            .map<DropdownMenuItem<ComplementType>>(
                (ComplementType item) => DropdownMenuItem<ComplementType>(
                      value: item,
                      child: Text(item.name),
                    ))
            .toList(),
      ),
    );

    return SentenceScaffold(
      title: 'Subject complement',
      bottomActions: [
        IconButton(
          onPressed: canSave ? () => Navigator.pop(context, complement) : null,
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.clear),
        ),
      ],
      body: switch (type) {
        ComplementType.nounPhrase => NounPhraseForm(
            setNounPhrase: setComplement,
            nounPhrase:
                complement is NounPhrase ? complement as NounPhrase : null,
            settingsControl: settingsControl,
            setCanSave: setCanSave,
          ),
        ComplementType.adjective => AdjectiveForm(
            setAdjective: setComplement,
            adjective: complement is Adjective ? complement as Adjective : null,
            settingsControl: settingsControl,
            setCanSave: setCanSave,
          ),
        _ => PronounForm(
            pronouns: pronouns,
            setPronoun: setComplement,
            pronoun: complement is Pronoun ? complement as Pronoun : null,
            setCanSave: setCanSave,
            settingsControl: settingsControl,
          ),
      },
    );
  }

  setComplement(SubjectComplement? complement) =>
      setState(() => this.complement = complement);

  setType(ComplementType type) => setState(() => this.type = type);

  setCanSave(bool canSave) => setState(() => this.canSave = canSave);
}
