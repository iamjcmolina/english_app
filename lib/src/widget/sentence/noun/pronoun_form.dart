import 'package:flutter/material.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/pronoun.dart';
import '../../../model/word.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class PronounForm extends StatefulWidget {
  final Widget settingsControl;
  final List<Pronoun> pronouns;
  final Pronoun? pronoun;
  final void Function(Pronoun?) setPronoun;

  const PronounForm({
    super.key,
    required this.settingsControl,
    required this.pronouns,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  State<PronounForm> createState() => _PronounFormState();
}

class _PronounFormState extends State<PronounForm> {
  bool isFieldShown = false;

  @override
  Widget build(BuildContext context) {
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
          ItemField<Pronoun>(
            label: Label.personalPronoun,
            options: widget.pronouns,
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
