import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/noun/any_noun.dart';
import '../../../model/sentence/phrase/gerund_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adverb_page.dart';
import '../../page/object_page.dart';

class GerundPhraseForm extends StatelessWidget {
  final Widget settingsControl;
  final GerundPhrase phrase;
  final void Function(GerundPhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const GerundPhraseForm({
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
              TextSpan(
                text: phrase.object == null && phrase.adverb == null
                    ? '<ObjectOrModifier> '
                    : '',
                style: SentenceItem.placeholder.style,
              ),
              TextSpan(
                text: phrase.object == null ? '' : '${phrase.object!.en} ',
                style: SentenceItem.noun.style,
              ),
              TextSpan(
                text: phrase.adverb == null ? '' : '${phrase.adverb!.en} ',
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
          textValueEs: phrase.verb?.infinitiveEs,
          required: true,
          fields: [
            SentenceItemField<AnyVerb>(
              label: 'ProgressiveVerb',
              value: phrase.verb,
              displayStringForOption: (e) => e.progressive,
              options: vocabularyRepository.actionVerbs(),
              filterValuesEn: [(AnyVerb e) => e.progressive],
              filterValuesEs: [(AnyVerb e) => e.infinitiveEs],
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
          onTap: () => navigateToObjectPage(context),
        ),
        SentenceItemTile(
          style: SentenceItem.adverb.style,
          placeholder: "<Modifier>",
          en: phrase.adverb?.en,
          es: phrase.adverb?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToAdverbPage(context),
        ),
      ],
    );
  }

  void setVerb(AnyVerb? verb) =>
      validateAndSet(phrase.copyWith(verb: Nullable(verb)));

  void setObject(AnyNoun? object) =>
      validateAndSet(phrase.copyWith(object: Nullable(object)));

  void setModifier(AnyAdverb? adverb) =>
      validateAndSet(phrase.copyWith(adverb: Nullable(adverb)));

  void validateAndSet(GerundPhrase phrase) {
    setPhrase(phrase);
  }

  void navigateToObjectPage(BuildContext context) async {
    final object = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectPage(
                  object: phrase.object,
                  isDitransitiveVerb: false,
                  isIndirectObject: false,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (object is AnyNoun) {
      setObject(object);
    } else if (object is bool && !object) {
      setObject(null);
    }
  }

  void navigateToAdverbPage(BuildContext context) async {
    final adverb = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbPage(
                  adverb: phrase.adverb,
                  position: AdverbPosition.end,
                  isNegative: isNegative,
                  isPlural: isPlural,
                )));
    if (adverb is AnyAdverb) {
      setModifier(adverb);
    } else if (adverb is bool && !adverb) {
      setModifier(null);
    }
  }
}
