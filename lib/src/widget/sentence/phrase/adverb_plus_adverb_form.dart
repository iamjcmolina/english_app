import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/phrase/adverb_plus_adverb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class AdverbPlusAdverbForm extends StatefulWidget {
  final Widget settingsControl;
  final AdverbPlusAdverb phrase;
  final void Function(AdverbPlusAdverb?) setPhrase;

  const AdverbPlusAdverbForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
  });

  @override
  State<AdverbPlusAdverbForm> createState() => _AdverbPlusAdverbFormState();
}

class _AdverbPlusAdverbFormState extends State<AdverbPlusAdverbForm> {
  bool isDegreeAdverbFieldShown = false;
  bool isAdverbFieldShown = false;

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
                text: (widget.phrase.degreeAdverb?.en ?? Label.degreeAdverb)
                    .addSpace(),
                style: widget.phrase.degreeAdverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              TextSpan(
                text: (widget.phrase.adverb?.en ?? Label.adverb).addSpace(),
                style: widget.phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: (widget.phrase.degreeAdverb?.es ?? Label.degreeAdverbEs)
                    .addSpace(),
                style: widget.phrase.degreeAdverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              TextSpan(
                text: (widget.phrase.adverb?.es ?? Label.adverbEs).addSpace(),
                style: widget.phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        if (!isDegreeAdverbFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleDegreeAdverbField,
            style: Word.adverb.style,
            placeholder: Label.degreeAdverb,
            en: widget.phrase.degreeAdverb?.en,
            es: widget.phrase.degreeAdverb?.es,
            isRequired: true,
          ),
        if (isDegreeAdverbFieldShown)
          ItemField<Adverb>(
            label: Label.degreeAdverb,
            options: vocabularyRepository.degreeAdverbs(),
            value: widget.phrase.degreeAdverb,
            toEnString: (e) => e.en,
            toEsString: (e) => e.es,
            setValue: setDegreeAdverb,
            getHelperText: (e) => e.help,
            onAccept: toggleDegreeAdverbField,
          ),
        if (!isAdverbFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleAdverbField,
            style: Word.adverb.style,
            placeholder: Label.adverb,
            en: widget.phrase.adverb?.en,
            es: widget.phrase.adverb?.es,
            isRequired: true,
          ),
        if (isAdverbFieldShown)
          ItemField<Adverb>(
            label: Label.adverb,
            value: widget.phrase.adverb,
            setValue: setAdverb,
            options: vocabularyRepository.endAdverbs(),
            toEnString: (e) => e.en,
            toEsString: (e) => e.es,
            getHelperText: (e) => e.help,
            onAccept: toggleAdverbField,
          ),
      ],
    );
  }

  void setDegreeAdverb(Adverb? adverb) =>
      widget.setPhrase(widget.phrase.copyWith(degreeAdverb: Nullable(adverb)));

  void setAdverb(Adverb? adverb) =>
      widget.setPhrase(widget.phrase.copyWith(adverb: Nullable(adverb)));

  toggleDegreeAdverbField() =>
      setState(() => isDegreeAdverbFieldShown = !isDegreeAdverbFieldShown);

  toggleAdverbField() =>
      setState(() => isAdverbFieldShown = !isAdverbFieldShown);
}
