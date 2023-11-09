import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/phrase/past_participle_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import '../../page/adverbial_phrase_page.dart';

class PastParticiplePhraseForm extends StatefulWidget {
  final Widget settingsControl;
  final PastParticiplePhrase phrase;
  final void Function(PastParticiplePhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const PastParticiplePhraseForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<PastParticiplePhraseForm> createState() =>
      _PastParticiplePhraseFormState();
}

class _PastParticiplePhraseFormState extends State<PastParticiplePhraseForm> {
  bool isVerbFieldShown = false;

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
                text: (widget.phrase.verb?.pastParticiple ??
                        Label.pastParticipleVerb)
                    .addSpace(),
                style: widget.phrase.verb == null
                    ? Word.empty.style
                    : Word.verb.style,
              ),
              TextSpan(
                text: (widget.phrase.adverb?.en ?? Label.adverb).addSpace(),
                style: widget.phrase.adverb == null
                    ? Word.empty.style
                    : Word.adverb.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: (widget.phrase.verb?.pastParticipleEs ??
                        Label.pastParticipleVerbEs)
                    .addSpace(),
                style: widget.phrase.verb == null
                    ? Word.empty.style
                    : Word.verb.style,
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
        if (!isVerbFieldShown)
          ItemTile(
            trailing: const Icon(Icons.edit),
            onTap: toggleVerbField,
            style: Word.verb.style,
            placeholder: Label.progressiveVerb,
            en: widget.phrase.verb?.pastParticiple,
            es: widget.phrase.verb?.pastParticipleEs,
            isRequired: true,
          ),
        if (isVerbFieldShown)
          ItemField<AnyVerb>(
            label: Label.pastParticipleVerb,
            options: vocabularyRepository.actionVerbs(),
            value: widget.phrase.verb,
            setValue: setVerb,
            toEnString: (AnyVerb e) => e.pastParticiple,
            toEsString: (AnyVerb e) => e.pastParticipleEs,
            getHelperText: (e) => e.help,
            onAccept: toggleVerbField,
          ),
        ItemTile(
          style: Word.adverb.style,
          placeholder: Label.adverb,
          en: widget.phrase.adverb?.en,
          es: widget.phrase.adverb?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToAdverbialPhrasePage(context),
        ),
      ],
    );
  }

  void setVerb(AnyVerb? verb) =>
      widget.setPhrase(widget.phrase.copyWith(verb: Nullable(verb)));

  void setAdverbialPhrase(AnyAdverb? adverb) =>
      widget.setPhrase(widget.phrase.copyWith(adverb: Nullable(adverb)));

  void goToAdverbialPhrasePage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbialPhrasePage(
                adverb: widget.phrase.adverb,
                position: AdverbPosition.end,
                isNegative: widget.isNegative,
                isPlural: widget.isPlural)));
    if (response != null) {
      setAdverbialPhrase(response is AnyAdverb ? response : null);
    }
  }

  toggleVerbField() => setState(() => isVerbFieldShown = !isVerbFieldShown);
}
