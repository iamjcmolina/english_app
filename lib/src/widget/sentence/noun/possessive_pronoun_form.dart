import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/possessive_pronoun.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class PossessivePronounForm extends StatefulWidget {
  final Widget settingsControl;
  final PossessivePronoun? pronoun;
  final void Function(PossessivePronoun?) setPronoun;

  const PossessivePronounForm({
    super.key,
    required this.settingsControl,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  State<PossessivePronounForm> createState() => _PronounFormState();
}

class _PronounFormState extends State<PossessivePronounForm> {
  bool isFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        widget.settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: widget.pronoun?.en ?? Label.personalPronoun,
                  style: widget.pronoun == null
                      ? Word.empty.style
                      : Word.noun.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: widget.pronoun?.es ?? Label.personalPronounEs,
                  style: widget.pronoun == null
                      ? Word.empty.style
                      : Word.noun.style),
            ],
          )),
        ),
      ],
      body: [
        if (!isFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleField,
            style: Word.noun.style,
            placeholder: Label.personalPronoun,
            en: widget.pronoun?.en,
            es: null,
            isRequired: true,
          ),
        if (isFieldShown)
          ItemField<PossessivePronoun>(
            label: Label.personalPronoun,
            options: vocabularyRepository.possessivePronouns(),
            value: widget.pronoun,
            setValue: widget.setPronoun,
            toEnString: (pronoun) => pronoun.en,
            toEsString: (pronoun) => pronoun.es,
            onAccept: toggleField,
          ),
      ],
    );
  }

  toggleField() => setState(() => isFieldShown = !isFieldShown);
}
