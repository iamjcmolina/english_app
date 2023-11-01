import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/present_participle_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adverbial_phrase_page.dart';
import '../../page/object_page.dart';

class PresentParticiplePhraseForm extends StatelessWidget {
  final Widget settingsControl;
  final PresentParticiplePhrase phrase;
  final void Function(PresentParticiplePhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const PresentParticiplePhraseForm({
    super.key,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyRepository = Provider.of<VocabularyRepository>(context);

    return ItemEditorLayout(
      header: [
        settingsControl,
        ListTile(
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: phrase.verb == null
                    ? '<ProgressiveVerb> '
                    : '${phrase.verb!.progressive} ',
                style: phrase.verb == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.verb.style,
              ),
              if (phrase.object != null && phrase.adverb != null)
                TextSpan(
                  text: '<ObjectOrAdverb> ',
                  style: SentenceItem.placeholder.style,
                ),
              if (phrase.object != null)
                TextSpan(
                  text: '${phrase.object!.en} ',
                  style: SentenceItem.noun.style,
                ),
              if (phrase.adverb != null)
                TextSpan(
                  text: '${phrase.adverb!.en} ',
                  style: SentenceItem.adverb.style,
                ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.verb.style,
          title: 'ProgressiveVerb',
          textValue: phrase.verb?.progressive,
          textValueEs: phrase.verb?.pastParticipleEs,
          required: true,
          fields: [
            SentenceItemField<AnyVerb>(
              label: 'ProgressiveVerb',
              value: phrase.verb,
              displayStringForOption: (e) => e.progressive,
              options: vocabularyRepository.actionVerbs(),
              filterValuesEn: [(AnyVerb e) => e.progressive],
              filterValuesEs: [(AnyVerb e) => e.pastParticipleEs],
              onSelected: (e) => setVerb(e),
              onChanged: (text) => setVerb(null),
            ),
          ],
        ),
        SentenceItemTile(
          style: SentenceItem.noun.style,
          placeholder: "<Object>",
          en: phrase.object?.en,
          es: phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToObjectPage(context),
        ),
        SentenceItemTile(
          style: SentenceItem.adverb.style,
          placeholder: "<Adverb>",
          en: phrase.adverb?.en,
          es: phrase.adverb?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => goToAdverbialPhrasePage(context),
        ),
      ],
    );
  }

  void setVerb(AnyVerb? verb) =>
      setPhrase(phrase.copyWith(verb: Nullable(verb)));

  void setObject(AnyNoun? object) =>
      setPhrase(phrase.copyWith(object: Nullable(object)));

  void setAdverbialPhrase(AnyAdverb? modifier) =>
      setPhrase(phrase.copyWith(adverb: Nullable(modifier)));

  void goToObjectPage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: phrase.object,
                  isDitransitiveVerb: false,
                  isIndirectObject: false,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    setObject(response is AnyNoun ? response : null);
  }

  void goToAdverbialPhrasePage(BuildContext context) async {
    final response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbialPhrasePage(
                adverb: phrase.adverb,
                position: AdverbPosition.end,
                isNegative: isNegative,
                isPlural: isPlural)));
    setAdverbialPhrase(response is AnyAdverb ? response : null);
  }
}
