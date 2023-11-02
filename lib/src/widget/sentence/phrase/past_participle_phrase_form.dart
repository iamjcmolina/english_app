import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions/string_extension.dart';
import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/adverb_position.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/phrase/past_participle_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../model/word.dart';
import '../../../repository/vocabulary_repository.dart';
import '../../common/dropdown_tile.dart';
import '../../common/item_editor_layout.dart';
import '../../common/sentence_item_field.dart';
import '../../common/sentence_item_tile.dart';
import '../../page/adverbial_phrase_page.dart';

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
                text: (phrase.verb?.pastParticiple ?? '<PastParticipleVerb>')
                    .addSpace(),
                style: phrase.verb == null ? Word.empty.style : Word.verb.style,
              ),
              TextSpan(
                text: (phrase.adverb?.en ?? '<Adverb>').addSpace(),
                style:
                    phrase.verb == null ? Word.empty.style : Word.adverb.style,
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          style: Word.verb.style,
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
          style: Word.adverb.style,
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

  void setAdverbialPhrase(AnyAdverb? adverb) =>
      setPhrase(phrase.copyWith(adverb: Nullable(adverb)));

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
