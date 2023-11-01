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
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final GerundPhrase phrase;
  final void Function(GerundPhrase?) setPhrase;
  final bool isNegative;
  final bool isPlural;

  const GerundPhraseForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
    required this.isPlural,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
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
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.verb.color),
              ),
              if (phrase.object != null && phrase.modifier != null)
                const TextSpan(
                  text: '<ObjectOrModifier> ',
                  style: unsetTextStyle,
                ),
              if (phrase.object != null)
                TextSpan(
                  text: '${phrase.object!.en} ',
                  style: TextStyle(color: SentenceItem.noun.color),
                ),
              if (phrase.modifier != null)
                TextSpan(
                  text: '${phrase.modifier!.en} ',
                  style: TextStyle(color: SentenceItem.adverb.color),
                ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: SentenceItem.verb.color,
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
          color: SentenceItem.noun.color,
          label: "<Object>",
          value: phrase.object?.en,
          valueEs: phrase.object?.es,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => navigateToObjectPage(context),
        ),
        SentenceItemTile(
          color: SentenceItem.adverb.color,
          label: "<Modifier>",
          value: phrase.modifier?.en,
          valueEs: phrase.modifier?.es,
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

  void setModifier(AnyAdverb? modifier) =>
      validateAndSet(phrase.copyWith(modifier: Nullable(modifier)));

  void validateAndSet(GerundPhrase phrase) {
    setCanSave(phrase.verb != null &&
        (phrase.object != null || phrase.modifier != null));
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
                  adverb: phrase.modifier,
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
