import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class AdjectiveForm extends StatefulWidget {
  final Widget settingsControl;
  final Adjective? adjective;
  final void Function(Adjective?) setAdjective;

  const AdjectiveForm({
    super.key,
    required this.settingsControl,
    required this.adjective,
    required this.setAdjective,
  });

  @override
  State<AdjectiveForm> createState() => _AdjectiveFormState();
}

class _AdjectiveFormState extends State<AdjectiveForm> {
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
                  text: widget.adjective?.en ?? Label.adjective,
                  style: widget.adjective == null
                      ? Word.empty.style
                      : Word.adjective.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: widget.adjective?.toEs() ?? Label.adjectiveEs,
                  style: widget.adjective == null
                      ? Word.empty.style
                      : Word.adjective.style),
            ],
          )),
        ),
      ],
      body: [
        if (!isFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleField,
            style: Word.adjective.style,
            placeholder: Label.adjective,
            en: widget.adjective?.en,
            es: null,
            isRequired: true,
          ),
        if (isFieldShown)
          ItemField<Adjective>(
            label: Label.adjective,
            value: widget.adjective,
            setValue: widget.setAdjective,
            options: vocabularyRepository.adjectives(),
            toEnString: (e) => e.en,
            toEsString: (e) => e.toEs(),
            onAccept: toggleField,
          ),
      ],
    );
  }

  toggleField() => setState(() => isFieldShown = !isFieldShown);
}
