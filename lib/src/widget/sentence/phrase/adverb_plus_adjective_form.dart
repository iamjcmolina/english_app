import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adjective/adjective.dart';
import '../../../model/sentence/adverb/adverb.dart';
import '../../../model/sentence/phrase/adverb_plus_adjective.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';

class AdverbPlusAdjectiveForm extends StatefulWidget {
  final Widget settingsControl;
  final AdverbPlusAdjective phrase;
  final void Function(AdverbPlusAdjective?) setPhrase;
  final bool isPlural;

  const AdverbPlusAdjectiveForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isPlural,
  });

  @override
  State<AdverbPlusAdjectiveForm> createState() =>
      _AdverbPlusAdjectiveFormState();
}

class _AdverbPlusAdjectiveFormState extends State<AdverbPlusAdjectiveForm> {
  bool isAdverbFieldShown = false;
  bool isAdjectiveFieldShown = false;

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
                text:
                    (widget.phrase.adjective?.en ?? Label.adjective).addSpace(),
                style: widget.phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
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
                text: (widget.phrase.adjective?.toEs() ?? Label.adjectiveEs)
                    .addSpace(),
                style: widget.phrase.adjective == null
                    ? Word.empty.style
                    : Word.adjective.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        if (!isAdverbFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleAdverbField,
            style: Word.adverb.style,
            placeholder: Label.degreeAdverb,
            en: widget.phrase.degreeAdverb?.en,
            es: widget.phrase.degreeAdverb?.es,
            isRequired: true,
          ),
        if (isAdverbFieldShown)
          ItemField<Adverb>(
            label: Label.degreeAdverb,
            options: vocabularyRepository.degreeAdverbs(),
            value: widget.phrase.degreeAdverb,
            setValue: (e) => setDegreeAdverb(e),
            toEnString: (e) => e.en,
            toEsString: (e) => e.es,
            getHelperText: (e) => e.help,
            onAccept: toggleAdverbField,
          ),
        if (!isAdjectiveFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleAdjectiveField,
            style: Word.adjective.style,
            placeholder: Label.adjective,
            en: widget.phrase.adjective?.en,
            es: widget.phrase.adjective?.toEs(widget.isPlural),
            isRequired: true,
          ),
        if (isAdjectiveFieldShown)
          ItemField<Adjective>(
            label: Label.adjective,
            options: vocabularyRepository.adjectives(),
            value: widget.phrase.adjective,
            setValue: setAdjective,
            toEnString: (e) => e.en,
            toEsString: (e) => e.toEs(widget.isPlural),
            onAccept: toggleAdjectiveField,
          ),
      ],
    );
  }

  void setDegreeAdverb(Adverb? adverb) =>
      widget.setPhrase(widget.phrase.copyWith(degreeAdverb: Nullable(adverb)));

  void setAdjective(Adjective? adjective) =>
      widget.setPhrase(widget.phrase.copyWith(adjective: Nullable(adjective)));

  toggleAdverbField() =>
      setState(() => isAdverbFieldShown = !isAdverbFieldShown);

  toggleAdjectiveField() =>
      setState(() => isAdjectiveFieldShown = !isAdjectiveFieldShown);
}
