import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/indefinite_pronoun.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class IndefinitePronounForm extends StatefulWidget {
  final Widget settingsControl;
  final bool isNegative;
  final IndefinitePronoun? pronoun;
  final void Function(IndefinitePronoun?) setPronoun;

  const IndefinitePronounForm({
    super.key,
    required this.settingsControl,
    required this.isNegative,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  State<IndefinitePronounForm> createState() => _IndefinitePronounFormState();
}

class _IndefinitePronounFormState extends State<IndefinitePronounForm> {
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
                  text: widget.pronoun?.en ?? Label.indefinitePronoun,
                  style: widget.pronoun == null
                      ? Word.empty.style
                      : Word.noun.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: widget.pronoun?.es ?? Label.indefinitePronounEs,
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
            placeholder: Label.indefinitePronoun,
            en: widget.pronoun?.en,
            es: null,
            isRequired: true,
          ),
        if (isFieldShown)
          ItemField<IndefinitePronoun>(
            label: Label.indefinitePronoun,
            options: vocabularyRepository.indefinitePronouns(widget.isNegative),
            value: widget.pronoun,
            setValue: widget.setPronoun,
            toEnString: (pronoun) => pronoun.en,
            toEsString: (pronoun) => pronoun.es,
            getHelperText: (e) => e.help,
            onAccept: toggleField,
          ),
      ],
    );
  }

  toggleField() => setState(() => isFieldShown = !isFieldShown);
}
