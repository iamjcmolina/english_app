import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/nullable.dart';
import '../../../model/sentence/adverb/any_adverb.dart';
import '../../../model/sentence/adverb/value/adverb_position.dart';
import '../../../model/sentence/clause/value/sentence_item.dart';
import '../../../model/sentence/phrase/past_participle_phrase.dart';
import '../../../model/sentence/verb/any_verb.dart';
import '../../../repository/verb_repository.dart';
import '../../item_editor_layout.dart';
import '../adverb/adverb_page.dart';
import '../dropdown_tile.dart';
import '../sentence_item_field.dart';
import '../sentence_item_tile.dart';

class PastParticiplePhraseForm extends StatelessWidget {
  final Function(bool) setCanSave;
  final Widget settingsControl;
  final PastParticiplePhrase phrase;
  final void Function(PastParticiplePhrase?) setPhrase;
  final bool isNegative;

  const PastParticiplePhraseForm({
    super.key,
    required this.setCanSave,
    required this.settingsControl,
    required this.phrase,
    required this.setPhrase,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    const unsetTextStyle = TextStyle(fontSize: 12);
    final verbRepository = Provider.of<VerbRepository>(context);

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
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.verb.color),
              ),
              TextSpan(
                text: phrase.modifier == null
                    ? '<Adverb> '
                    : '${phrase.modifier!.en} ',
                style: phrase.verb == null
                    ? unsetTextStyle
                    : TextStyle(color: SentenceItem.adverb.color),
              ),
            ],
          )),
        ),
      ],
      body: [
        DropdownTile(
          color: SentenceItem.verb.color,
          title: 'PastParticipleVerb',
          textValue: phrase.verb?.pastParticiple,
          textValueEs: phrase.verb?.pastParticipleEs,
          required: true,
          fields: [
            SentenceItemField<AnyVerb>(
              label: 'PastParticipleVerb',
              value: phrase.verb,
              displayStringForOption: (e) => e.pastParticiple,
              options: verbRepository.actionVerbs(),
              filterValuesEn: [(AnyVerb e) => e.pastParticiple],
              filterValuesEs: [(AnyVerb e) => e.pastParticipleEs],
              onSelected: (e) => setVerb(e),
              onChanged: (text) => setVerb(null),
            ),
          ],
        ),
        SentenceItemTile(
          color: SentenceItem.adverb.color,
          label: "<Adverb>",
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

  void setModifier(AnyAdverb? modifier) =>
      validateAndSet(phrase.copyWith(modifier: Nullable(modifier)));

  void validateAndSet(PastParticiplePhrase phrase) {
    setCanSave(phrase.verb != null && phrase.modifier != null);
    setPhrase(phrase);
  }

  void navigateToAdverbPage(BuildContext context) async {
    final adverb = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdverbPage(
                  adverb: phrase.modifier,
                  position: AdverbPosition.end,
                  isNegative: isNegative,
                )));
    if (adverb is AnyAdverb) {
      setModifier(adverb);
    } else if (adverb is bool && !adverb) {
      setModifier(null);
    }
  }
}
