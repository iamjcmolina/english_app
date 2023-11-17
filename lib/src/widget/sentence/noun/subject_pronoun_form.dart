import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/noun/subject_pronoun.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class SubjectPronounForm extends StatefulWidget {
  final Widget settingsControl;
  final SubjectPronoun? pronoun;
  final void Function(SubjectPronoun?) setPronoun;

  const SubjectPronounForm({
    super.key,
    required this.settingsControl,
    required this.pronoun,
    required this.setPronoun,
  });

  @override
  State<SubjectPronounForm> createState() => _SubjectPronounFormState();
}

class _SubjectPronounFormState extends State<SubjectPronounForm> {
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
          ItemField<SubjectPronoun>(
            label: Label.personalPronoun,
            options: vocabularyRepository.subjectPronouns(),
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
