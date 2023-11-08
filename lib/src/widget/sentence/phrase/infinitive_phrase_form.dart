import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/label.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/infinitive_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/item_editor_layout.dart';
import '../../common/item_field.dart';
import '../../common/item_tile.dart';
import '../../page/adverbial_phrase_page.dart';
import '../../page/object_page.dart';

class InfinitivePhraseForm extends StatefulWidget {
  final Widget settingsControl;
  final InfinitivePhrase phrase;
  final void Function(InfinitivePhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const InfinitivePhraseForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  State<InfinitivePhraseForm> createState() => _InfinitivePhraseFormState();
}

class _InfinitivePhraseFormState extends State<InfinitivePhraseForm> {
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
                text: widget.phrase.verb == null
                    ? '${Label.infinitiveVerb} '
                    : 'to ${widget.phrase.verb!.infinitive} ',
                style: widget.phrase.verb == null
                    ? Word.empty.style
                    : Word.verb.style,
              ),
              TextSpan(
                text:
                    widget.phrase.object == null && widget.phrase.adverb == null
                        ? Label.objectOrAdverb
                        : null,
                style: Word.empty.style,
              ),
              TextSpan(
                text: widget.phrase.object?.en.addSpace(),
                style: Word.noun.style,
              ),
              TextSpan(
                text: widget.phrase.adverb?.en.addSpace(),
                style: Word.adverb.style,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text:
                    (widget.phrase.verb?.infinitiveEs ?? Label.infinitiveVerbEs)
                        .addSpace(),
                style: widget.phrase.verb == null
                    ? Word.empty.style
                    : Word.verb.style,
              ),
              TextSpan(
                text:
                    widget.phrase.object == null && widget.phrase.adverb == null
                        ? Label.objectOrAdverbEs
                        : null,
                style: Word.empty.style,
              ),
              TextSpan(
                text: widget.phrase.object?.es.addSpace(),
                style: Word.noun.style,
              ),
              TextSpan(
                text: widget.phrase.adverb?.es.addSpace(),
                style: Word.adverb.style,
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
            en: widget.phrase.verb?.infinitive,
            es: widget.phrase.verb?.infinitiveEs,
            isRequired: true,
          ),
        if (isVerbFieldShown)
          ItemField<AnyVerb>(
            label: Label.infinitiveVerb,
            options: vocabularyRepository.verbs(),
            value: widget.phrase.verb,
            setValue: setVerb,
            toEnString: (AnyVerb e) => e.infinitive,
            toEsString: (AnyVerb e) => e.infinitiveEs,
            onAccept: toggleVerbField,
          ),
        ItemTile(
          style: Word.noun.style,
          placeholder: Label.object,
          en: widget.phrase.object?.en,
          es: widget.phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToObjectPage(context),
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

  void setObject(AnyNoun? object) =>
      widget.setPhrase(widget.phrase.copyWith(object: Nullable(object)));

  void setAdverbialPhrase(AnyAdverb? modifier) =>
      widget.setPhrase(widget.phrase.copyWith(adverb: Nullable(modifier)));

  void goToObjectPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                object: widget.phrase.object,
                isDitransitiveVerb: false,
                isIndirectObject: false,
                isNegative: widget.isNegative,
                isPlural: widget.isPlural)));
    if (response != null) {
      setObject(response is AnyNoun ? response : null);
    }
  }

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
