import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/phrase/past_participle_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/sentence_item.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adverb_page.dart';

class PastParticiplePhraseForm extends StatelessWidget {
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
                    ? '<PastParticipleVerb> '
                    : '${phrase.verb!.pastParticiple} ',
                style: phrase.verb == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.verb.style,
              ),
              TextSpan(
                text: phrase.adverb == null
                    ? '<Adverb> '
                    : '${phrase.adverb!.en} ',
                style: phrase.verb == null
                    ? SentenceItem.placeholder.style
                    : SentenceItem.adverb.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: SentenceItem.verb.style,
          title: 'PastParticipleVerb',
          textValue: phrase.verb?.pastParticiple,
          textValueEs: phrase.verb?.pastParticipleEs,
          required: true,
          fields: [
            SentenceItemField<AnyVerb>(
              label: 'PastParticipleVerb',
              value: phrase.verb,
              displayStringForOption: (e) => e.pastParticiple,
              options: vocabularyRepository.actionVerbs(),
              filterValuesEn: [(AnyVerb e) => e.pastParticiple],
              filterValuesEs: [(AnyVerb e) => e.pastParticipleEs],
              onSelected: (e) => setVerb(e),
              onChanged: (text) => setVerb(null),
            ),
          ],
        ),
        SentenceItemTile(
          style: SentenceItem.adverb.style,
          placeholder: "<Adverb>",
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

  void setModifier(AnyAdverb? modifier) =>
      validateAndSet(phrase.copyWith(adverb: Nullable(modifier)));

  void validateAndSet(PastParticiplePhrase phrase) {
    setPhrase(phrase);
  }

  void navigateToAdverbPage(BuildContext context) async {
    final adverb = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbPage(
                adverb: phrase.adverb,
                position: AdverbPosition.end,
                isNegative: isNegative,
                isPlural: isPlural)));
    if (adverb is AnyAdverb) {
      setModifier(adverb);
    } else if (adverb is bool && !adverb) {
      setModifier(null);
    }
  }
}
