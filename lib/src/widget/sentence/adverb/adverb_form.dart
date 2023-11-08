import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/label.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class AdverbForm extends StatefulWidget {
  final Widget settingsControl;
  final AdverbPosition position;
  final Adverb? adverb;
  final void Function(Adverb?) setAdverb;

  const AdverbForm({
    super.key,
    required this.settingsControl,
    required this.adverb,
    required this.setAdverb,
    required this.position,
  });

  @override
  State<AdverbForm> createState() => _AdverbFormState();
}

class _AdverbFormState extends State<AdverbForm> {
  bool isFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    List<Adverb> adverbs = switch (widget.position) {
      AdverbPosition.front => vocabularyRepository.frontAdverbs(),
      AdverbPosition.mid => vocabularyRepository.midAdverbs(),
      _ => vocabularyRepository.endAdverbs(),
    };

    return ItemEditorLayout(
      header: [
        widget.settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: widget.adverb?.en ?? Label.adverb,
                  style: widget.adverb == null
                      ? Word.empty.style
                      : Word.adverb.style),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: widget.adverb?.es ?? Label.adverbEs,
                  style: widget.adverb == null
                      ? Word.empty.style
                      : Word.adverb.style),
            ],
          )),
        ),
      ],
      body: [
        if (!isFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleField,
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: widget.adverb?.en,
            es: widget.adverb?.es,
            isRequired: true,
          ),
        if (isFieldShown)
          ItemField<Adverb>(
            label: Label.adverb,
            options: adverbs,
            value: widget.adverb,
            setValue: widget.setAdverb,
            toEnString: (e) => e.en,
            toEsString: (e) => e.es,
            onAccept: toggleField,
          ),
      ],
    );
  }

  toggleField() => setState(() => isFieldShown = !isFieldShown);
}
